class_name Mao extends CardContainer

@export var _cartas: Array[Carta]
var _posicoes: Array[Vector2]
var _limite_cartas: int
	
func _ready() -> void:
	super()
	_cartas = []
	_limite_cartas = 6
	_calcula_posicoes()
	
	child_entered_tree.connect(_entrou_carta)
	child_exiting_tree.connect(_saiu_carta)


func _calcula_posicoes() -> void:
	var posicao_mao = area.position
	var dimensoes_mao = area.find_child("CollisionShape2D").shape.size
	
	_posicoes.clear()
	
	if _cartas.is_empty():
		return
	
	var largura_total = 250 * (_cartas.size())
	var pos_inicial_x = posicao_mao.x + dimensoes_mao.x - largura_total

	for i in range(_cartas.size()):
		var pos := Vector2(
			pos_inicial_x + 200 * i,
			dimensoes_mao.y / 2
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
	print("MAO : ON CARD GRAB STARTED")
	super(carta)

	for c in _cartas:
		c.desabilita_hover_anim()
		if c != carta:
			c.disable_drag()

	move_child(carta, -1)


func canceled_card_move(_carta: Carta) -> void:
	print("MAO - canceled_card_move")
	_anima_cartas()


func received_own_card(_carta: Carta) -> void:
	print("MAOP - received_own_card")
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


func _anima_cartas() -> void:
	for i in range(_cartas.size()):
		var carta = _cartas[i]
		var tween = create_tween()
		tween.tween_property(carta, "position", _posicoes[i], 0.2)