class_name Mao extends Node2D

@export var cartas: Array[Carta]
var posicoes: Array[Vector2]
var posicao_final: Vector2
var carta_sendo_segurada := false
var carta_segurada: Carta
var posicao_mao: Vector2
var largura_mao: float
var altura_mao: float
var limite_cartas: int
	
func _ready() -> void:
	cartas = []
	calcula_posicoes()
	
	child_entered_tree.connect(_entrou_carta)
	child_exiting_tree.connect(_saiu_carta)


func set_mao(pos: Vector2, width: float, height: float) -> void:
	limite_cartas = 6
	posicao_mao = pos
	largura_mao = width
	altura_mao = height
	calcula_posicoes()


func calcula_posicoes() -> void:
	posicoes.clear()
	
	if cartas.is_empty():
		return
	
	var largura_total = 200 * (cartas.size())
	var pos_inicial_x = posicao_mao.x + largura_mao - largura_total
	var pos_carta_y = posicao_mao.y + (altura_mao - 300) / 2

	for i in range(cartas.size()):
		var pos := Vector2(
			pos_inicial_x + 200 * i,
			pos_carta_y
		)
		posicoes.append(pos)


func add_carta(carta: Carta) -> void:
	if cartas.size() >= limite_cartas:
		return

	cartas.push_front(carta)
	
	add_child(carta)
	carta.inicia_arrasto.connect(_arrastar_carta_iniciado.bind(carta))
	carta.fim_do_arrasto.connect(_arrastar_carta_finalizado.bind(carta))
	
	calcula_posicoes()
	anima_cartas()


func _entrou_carta(node: Node) -> void:
	if node is Carta and not cartas.has(node):
		add_carta(node as Carta)


func _saiu_carta(node: Node) -> void:
	if node is Carta:
		var carta = node as Carta
		var i = cartas.find(carta)
		cartas.remove_at(i)
		calcula_posicoes()
		anima_cartas()


func _arrastar_carta_iniciado(carta: Carta) -> void:
	carta_sendo_segurada = true

	for c in cartas:
		c.desabilita_hover_anim()
		if c != carta:
			c.desabilita_arrastar()
	move_child(carta, -1)


func _arrastar_carta_finalizado(carta: Carta) -> void:
	carta_sendo_segurada = false

	for c in cartas:
		c.habilita_hover_anim()
		c.habilita_arrastar()

	if sobre_a_mao(carta.position):
		var indice_carta = cartas.find(carta)
		var pos_alvo = indice_carta
		var dist_minima = INF
		
		for i in range(posicoes.size()):
			var dist = carta.position.distance_to(posicoes[i])
			if dist < dist_minima:
				dist_minima = dist
				pos_alvo = i
		
		if pos_alvo != indice_carta:
			cartas.remove_at(indice_carta)
			cartas.insert(pos_alvo, carta)
			calcula_posicoes()
	
		anima_cartas()
		return

	var monstro_slot = Partida.get_mesa().get_monstro_slot()
	if monstro_slot and _carta_no_slot(monstro_slot, carta):
		remove_child(carta)
		monstro_slot.add_monstro(carta)
		return
	
	var descarte_slot = Partida.get_mesa().get_descarte_slot()
	if descarte_slot and _carta_no_slot(descarte_slot, carta):
		remove_child(carta)
		descarte_slot.add_descarte(carta)
		return

	anima_cartas()
	return

func anima_cartas() -> void:
	for i in range(cartas.size()):
		var carta = cartas[i]
		var tween = create_tween()
		tween.tween_property(carta, "position", posicoes[i], 0.2)


func sobre_a_mao(pos: Vector2) -> bool:
	var area_mao := Rect2(
		posicao_mao,
		Vector2(largura_mao, altura_mao)
	)
	return area_mao.has_point(pos)

func _carta_no_slot(slot: Slot, carta: Carta) -> bool:
	var carta_rect = Rect2(
		carta.global_position,
		Vector2(200, 300))
	var slot_rect := Rect2(
		slot.position,
		Vector2(200, 300))
	return carta_rect.intersects(slot_rect)
