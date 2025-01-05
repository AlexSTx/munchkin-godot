class_name Slot extends CardContainer

var _carta: Carta = null



func add_carta(carta: Carta) -> void:
	connect_carta(carta)
	if not can_receive_cards:
		return

	if has_carta():
		return 

	_carta = carta
	add_child(_carta)
	_carta.position = Vector2.ZERO
		

func remove_carta(carta: Carta) -> void:
	if carta == _carta:
		disconnect_carta(carta)
		remove_child(carta)

		_carta = null

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
