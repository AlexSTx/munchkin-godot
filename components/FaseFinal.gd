extends "res://components/Fase/Fase.gd"

signal FimDaFaseFinal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("FimDaFaseFinal", Callable(Partida.get_turno(), "passar_fase"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_prox_button_up() -> void:
	emit_signal("FimDaFaseFinal")

func set_fase() -> void:
	pass
