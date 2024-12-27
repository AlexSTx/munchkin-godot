extends "res://components/Fase/Fase.gd"

class_name Preparo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func baterNaPorta() -> void:
	Partida.get_mesa().get_porta()
