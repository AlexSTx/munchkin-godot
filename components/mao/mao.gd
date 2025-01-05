class_name Mao extends CardContainer

@export var _cartas: Array[Carta]
var _posicoes: Array[Vector2]
var _limite_cartas: int
	
func _ready() -> void:
	super()
	_cartas = []
	_limite_cartas = 6
	_calcula_posicoes()
	

func _calcula_posicoes() -> void:
	# var posicao_mao = area.position
	var dimensoes_mao = area.find_child("CollisionShape2D").shape.size

	_posicoes.clear()
	
	if _cartas.is_empty():
		return
	
	var largura_total = 190 * (_cartas.size())
	var pos_inicial_x = dimensoes_mao.x/2 - largura_total/2

	for i in range(_cartas.size()):
		var pos := Vector2(
			pos_inicial_x + 190 * i,
			dimensoes_mao.y / 2
		)
		_posicoes.append(pos)


func accepts_card(_carta: Carta) -> bool:
	return _cartas.size() < _limite_cartas


func add_carta(carta: Carta) -> void:
	connect_carta(carta)

	_cartas.push_front(carta)
	add_child(carta)

	_calcula_posicoes()
	_anima_cartas()


func remove_carta(carta: Carta) -> void:
	disconnect_carta(carta)
	remove_child(carta)

	var i = _cartas.find(carta)
	_cartas.remove_at(i)

	_calcula_posicoes()
	_anima_cartas()


func on_card_grab_started(carta: Carta) -> void:
	print("MAO : ON CARD GRAB STARTED ", self.name)
	super(carta)

	for c in _cartas:
		c.desabilita_hover_anim()
		if c != carta:
			c.disable_drag()

	move_child(carta, -1)


func canceled_card_move(_carta: Carta) -> void:
	print("MAO - canceled_card_move ", self.name)
	_anima_cartas()


func received_own_card(_carta: Carta) -> void:
	print("MAOP - received_own_card ", self.name)
	var indice_carta = _cartas.find(_carta)
	var pos_alvo = indice_carta
	var dist_minima = INF
	
	for i in range(_posicoes.size()):
		var dist = _carta.position.distance_to(_posicoes[i])
		if dist < dist_minima:
			dist_minima = dist
			pos_alvo = i
	
	if pos_alvo != indice_carta:
		_cartas.remove_at(indice_carta)
		_cartas.insert(pos_alvo, _carta)
		_calcula_posicoes()
		carta.descartada_por.emit(self.get_parent())

	if _carta_no_host(carta):
		print("Carta no host")
		if handle_carta_no_host(carta, descarte_slot) == OK:
			return

	_anima_cartas()


func on_card_grab_ended(_carta: Carta) -> void:
	for c in _cartas:
		c.habilita_hover_anim()
		c.enable_drag()


func _anima_cartas() -> void:
	for i in range(_cartas.size()):
		var carta = _cartas[i]
		var tween = create_tween()
		tween.tween_property(carta, "position", _posicoes[i], 0.2)


func _on_hud_open() -> void:
	print("ABRIU HUD")
	self.area.collision_layer = 2
	self.area.collision_mask = 2
	for c in _cartas:
		c.click_area.collision_layer = 2
		c.click_area.collision_mask = 2


func _on_hud_closed() -> void:
	print("FECHOU HUD")
	self.area.collision_layer = 1
	self.area.collision_mask = 1
	for c in _cartas:
		c.click_area.collision_layer = 1
		c.click_area.collision_mask = 1

func handle_carta_no_host(carta : Carta, descarte_slot : DescarteSlot):
	var host : JogadorHost = Partida.get_node("Jogador Host") as JogadorHost
	# TODO: Refatorar essas checagens para evitar repetições
	if carta is Pocao or carta is Habilidade:
		if carta.satisfaz_alguma_restricao(host) :
			remove_child(carta)
			descarte_slot.add_carta_no_slot(carta)
			print("Carta " + carta.titulo + " pode ser usada. Aplicando efeitos")
			carta.aplicar_todos_efeitos(host)
			print("Efeitos Aplicados")
			return OK
	elif carta is Equipamento:
		if host.get_inventario().equiparItem(carta) == OK:
			remove_child(carta)
			for ef in carta.get_efeitos():
				if ef.restricoes.has(RestricaoNaoEquipavel):
					continue
				host.status.adicionar_efeito_ativo(ef)
	else:
			print("Carta não aplicável")
