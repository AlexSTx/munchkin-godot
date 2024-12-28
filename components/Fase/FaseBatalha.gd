extends "res://components/Fase/Fase.gd"

signal FimDaBatalha

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("FimDaBatalha", Callable(Partida.get_turno(), "passar_fase"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func FimBatalha() -> void:
	emit_signal("FimDaBatalha")
	
func set_fase() -> void:
	print("setou batalha")
	pass
