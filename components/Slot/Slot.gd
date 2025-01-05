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


func has_carta() -> bool:
	return _carta != null


func get_carta() -> Carta:
	return _carta

