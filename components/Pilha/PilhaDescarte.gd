class_name DescarteSlot extends Slot

signal carta_descartada

var _ultimo_descarte: Carta = null

func has_descarte() -> bool:
	return _ultimo_descarte != null

func get_ultimo_descarte() -> Carta:
	return _ultimo_descarte

func add_descarte(carta: Carta) -> void:
	if _ultimo_descarte:
		remove_descarte_antigo()
	_ultimo_descarte = carta
	carta.position = Vector2.ZERO
	add_child(carta)
	carta.visible = true
	emit_signal("carta_descartada")
	carta.disable_drag()

func remove_descarte_antigo() -> void:
	if _ultimo_descarte:
		var descarte = _ultimo_descarte
		remove_child(descarte)
		_ultimo_descarte = null
