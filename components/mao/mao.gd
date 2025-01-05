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
	var largura_carta = 180
	var qtd_cartas = _cartas.size()

	var padding = 10

	_posicoes.clear()
	
	if _cartas.is_empty():
		return
	
	var largura_total = (largura_carta + padding) * qtd_cartas
	var pos_inicial_x = largura_carta/2.0 - largura_total/2.0

	for i in range(_cartas.size()):
		var pos := Vector2(
			pos_inicial_x + (largura_carta + padding) * i,
			0
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
		_carta.descartada_por.emit(self.get_parent())

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

		
func get_limite():
	return _limite_cartas

func get_cartas_na_mao():
	return _cartas.size()
	
