extends Node

class_name Fase

var titulo: String
var jogador_atual: Jogador

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_jogador_atual(jogador: Jogador) -> void:
	jogador_atual = jogador

func set_fase() -> void:
	pass
