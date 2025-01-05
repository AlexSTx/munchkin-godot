class_name Mesa extends Node2D

@onready var _tesouro: PilhaTesouro = $PilhaTesouro
@onready var _porta: PilhaPorta = $PilhaPorta
@onready var _monstro_slot: MonstroSlot = $MonstroSlot
@onready var _descarte_slot: DescarteSlot = $DescarteSlot

func _ready() -> void:
	_porta.setup_highlight()
	_descarte_slot.set_image(load("res://components/cartasimg/Slots-20250103T142627Z-001/Slots/IMG_4651.png"))
func get_porta() -> PilhaPorta:
	return _porta
	
func get_tesouro() -> PilhaTesouro:
	return _tesouro

func get_monstro_slot() -> MonstroSlot:
	return _monstro_slot

func get_descarte_slot() -> DescarteSlot:
	return _descarte_slot
