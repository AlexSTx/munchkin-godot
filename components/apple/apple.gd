extends Node2D

@export var color: Color

func _ready():
	print('iniciei papai')
	modulate = color

func _process(delta: float) -> void:
	pass
