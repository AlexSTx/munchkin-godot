class_name Slot extends CardContainer

signal put_card(carta: Carta)
signal took_card(carta: Carta)

var _carta: Carta = null
@export var img: Texture2D

func _ready() -> void:
	super()
	$Sprite2D.texture = img


func satisfaz_cond(carta : Carta):
	# Referencia direto ao jogador não é ideal
	var host : Jogador = Partida.get_node("Jogador Host") as Jogador
	return carta.satisfaz_todas_restricoes(host)


func add_carta(carta: Carta) -> void:
	connect_carta(carta)
	if not can_receive_cards:
		return

	if has_carta(): 
		return 

	_carta = carta
	add_child(_carta)
	_carta.position = Vector2.ZERO
	put_card.emit(carta)
	# Aplica os efeitos permanentes da carta
	var host : Jogador = Partida.get_node("Jogador Host") as Jogador
	for ef in carta.get_efeitos():
		if not ef.restricoes.has(RestricaoNaoEquipavel):
			host.status.adicionar_efeito_ativo(ef)

func remove_carta(carta: Carta) -> void:
	if carta == _carta:
		disconnect_carta(carta)
		remove_child(carta)
		_carta = null
		took_card.emit(carta)
		# Remover efeitos permanentes da carta
		var host : Jogador = Partida.get_node("Jogador Host") as Jogador
		for ef in carta.get_efeitos():
			# TODO: Melhorar esse sistema
			if ef in host.status.efeitos_ativos.efeitos:
				host.status.remover_efeito_ativo(ef)


func canceled_card_move(carta: Carta) -> void:
	var tween = create_tween()
	tween.tween_property(carta, "position", Vector2.ZERO, 0.2)


func received_own_card(carta: Carta) -> void:
	var tween = create_tween()
	tween.tween_property(carta, "position", Vector2.ZERO, 0.2)


func has_carta() -> bool:
	return _carta != null


func get_carta() -> Carta:
	return _carta


func highlight() -> void:
	show_highlight = true
	queue_redraw()


func disable_highlight() -> void:
	show_highlight = false
	queue_redraw()


func _draw() -> void:
	if not show_highlight:
		return

	if $Area2D/CollisionShape2D and $Area2D/CollisionShape2D.shape is RectangleShape2D:
		var size = $Area2D/CollisionShape2D.shape.size
		var rect = Rect2(-size/2, size)  
		draw_rect(rect, Color.WHITE, false, 8.0)

func set_image(texture: Texture2D) -> void:
	var sprite = $Sprite2D
	if sprite:
		sprite.texture = texture
