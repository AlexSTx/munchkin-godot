class_name DescarteSlot extends Slot

signal carta_descartada

func add_carta_no_slot(carta: Carta) -> void:
	if _carta_no_slot:
		remove_carta_do_slot()
	_carta_no_slot = carta
	carta.position = Vector2.ZERO
	add_child(carta)
	carta.visible = true
	emit_signal("carta_descartada")
	carta.disable_drag()

func remove_carta_do_slot() -> void:
	if _carta_no_slot:
		var carta = _carta_no_slot
		remove_child(carta)
		_carta_no_slot = null
