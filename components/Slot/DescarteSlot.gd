class_name DescarteSlot extends Slot

signal carta_descartada

func add_carta(carta: Carta) -> void:
	connect_carta(carta)
	if not can_receive_cards:
		return

	if _carta:
		remove_carta(_carta)

	_carta = carta
	add_child(carta)
	carta.position = Vector2.ZERO

	carta_descartada.emit()
	carta.disable_drag()
