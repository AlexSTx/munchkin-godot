class_name Mesa extends Node2D

var _tesouro: PilhaTesouro
var _porta: PilhaPorta
var _monstro_slot: MonstroSlot
var _descarte_slot: DescarteSlot

func set_mesa() -> void:
	_tesouro = PilhaTesouro.new()
	_porta = PilhaPorta.new()

	_tesouro.name = "BaralhoTesouro"
	_porta.name = "BaralhoPorta"

	_monstro_slot = MonstroSlot.new()
	_monstro_slot.set_image(load("res://components/cartasimg/Slots-20250103T142627Z-001/Slots/IMG_4652.png"))
	
	_descarte_slot = DescarteSlot.new()
	_descarte_slot.set_image(load("res://components/cartasimg/Slots-20250103T142627Z-001/Slots/IMG_4651.png"))	
	
	_tesouro.set_image(load("res://assets/tesouro.png"))
	_porta.set_image(load("res://assets/porta.png"))
	
	_tesouro.set_size(Vector2(200, 300))
	_porta.set_size(Vector2(200, 300))

	_monstro_slot.position = Vector2(960, 500)
	_descarte_slot.position = Vector2(1770, 500)
	
	_monstro_slot.set_size(Vector2(200, 300))
	_descarte_slot.set_size(Vector2(200, 300))

	add_child(_tesouro)
	add_child(_porta)
	add_child(_monstro_slot)
	add_child(_descarte_slot)
	
	_tesouro.set_pilha()
	_porta.set_pilha()
		
	_tesouro.position = Vector2(150, 500)
	_porta.position = Vector2(380, 500)
	_porta.setup_highlight()

func get_porta() -> PilhaPorta:
	return _porta
	
func get_tesouro() -> PilhaTesouro:
	return _tesouro

func get_monstro_slot() -> MonstroSlot:
	return _monstro_slot

func get_descarte_slot() -> DescarteSlot:
	return _descarte_slot
