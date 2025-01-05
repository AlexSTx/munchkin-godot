class_name Slot extends CardContainer

var _carta: Carta = null

func has_carta() -> bool:
	return _carta != null


func get_carta() -> Carta:
	return _carta


func remove_carta() -> void:
	pass