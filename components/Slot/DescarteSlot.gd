class_name DescarteSlot extends Slot

signal carta_descartada

func add_carta(carta: Carta) -> void:
	if not can_receive_cards:
		return

	if _carta:
		remove_carta()
	_carta = carta
	carta.position = Vector2.ZERO
	add_child(carta)
	carta.visible = true
	emit_signal("carta_descartada")
	carta.disable_drag()


func remove_carta() -> void:
	if _carta:
		var carta = _carta
		remove_child(carta)
		_carta = null
