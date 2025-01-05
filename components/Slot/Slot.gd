class_name Slot extends CardContainer

var _carta: Carta = null

func add_card(carta: Carta) -> void:
	if not has_carta():
		_carta = carta
		add_child(carta)
		carta.position = Vector2.ZERO
		

func has_carta() -> bool:
	return _carta != null


func get_carta() -> Carta:
	return _carta


func remove_carta() -> void:
	pass