class_name Mao extends CardContainer

@export var _cartas: Array[Carta]
var _posicoes: Array[Vector2]
var _limite_cartas: int
	
func _ready() -> void:
	_cartas = []
	_calcula_posicoes()
	
	child_entered_tree.connect(_entrou_carta)
	child_exiting_tree.connect(_saiu_carta)


func set_mao() -> void:
	_limite_cartas = 6
	_calcula_posicoes()


func _calcula_posicoes() -> void:
	var posicao_mao = area.position
	var dimensoes_mao = area.find_child("CollisionShape2D").shape.size
	
	_posicoes.clear()
	
	if _cartas.is_empty():
		return
	
	var largura_total = 250 * (_cartas.size())
	var pos_inicial_x = posicao_mao.x + dimensoes_mao.x - largura_total
	var pos_carta_y = posicao_mao.y + (dimensoes_mao.y - 300) / 2

	for i in range(_cartas.size()):
		var pos := Vector2(
			pos_inicial_x + 200 * i,
			pos_carta_y
		)
		_posicoes.append(pos)


func add_carta(carta: Carta) -> void:
	if _cartas.size() >= _limite_cartas:
		return

	super(carta)

	_cartas.push_front(carta)
	
	add_child(carta)
	
	_calcula_posicoes()
	_anima_cartas()


func _entrou_carta(node: Node) -> void:
	if node is Carta and not _cartas.has(node):
		add_carta(node as Carta)


func _saiu_carta(node: Node) -> void:
	if node is Carta:
		var carta = node as Carta
		var i = _cartas.find(carta)
		_cartas.remove_at(i)
		_calcula_posicoes()
		_anima_cartas()


func on_card_grab_started(carta: Carta) -> void:
	super(carta)

	for c in _cartas:
		c.desabilita_hover_anim()
		if c != carta:
			c.disable_drag()

	move_child(carta, -1)


func canceled_card_move(_carta: Carta) -> void:
	_anima_cartas()


func received_own_card(_carta: Carta) -> void:
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

	_anima_cartas()


func on_card_grab_ended(_carta: Carta) -> void:
	for c in _cartas:
		c.habilita_hover_anim()
		c.enable_drag()

	# var monstro_slot = Partida.get_mesa().get_monstro_slot()
	# if monstro_slot and _carta_no_slot(monstro_slot, carta) and carta is Monstro:
	# 	remove_child(carta)
	# 	monstro_slot.add_carta_no_slot(carta)
	# 	return
	
	# var descarte_slot = Partida.get_mesa().get_descarte_slot()
	# if descarte_slot and _carta_no_slot(descarte_slot, carta):
	# 	remove_child(carta)
	# 	descarte_slot.add_carta_no_slot(carta)
	# 	return


func _anima_cartas() -> void:
	for i in range(_cartas.size()):
		var carta = _cartas[i]
		var tween = create_tween()
		tween.tween_property(carta, "position", _posicoes[i], 0.2)


# func _sobre_a_mao(pos: Vector2) -> bool:
# 	var area_mao := Rect2(
# 		_posicao_mao,
# 		Vector2(_largura_mao, _altura_mao)
# 	)
# 	return area_mao.has_point(pos)

# func _carta_no_slot(slot: Slot, carta: Carta) -> bool:
# 	var carta_rect = Rect2(
# 		carta.global_position,
# 		Vector2(200, 300))
# 	var slot_rect := Rect2(
# 		slot.position,
# 		Vector2(200, 300))
# 	return carta_rect.intersects(slot_rect)
