extends Node

class_name Turno

var jogador_atual: Jogador
var fase_atual: int
var fases: Array[Fase]

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func passar_fase() -> void:
	#adicionar mudar jogador
	if fase_atual < fases.size()-1:
		fase_atual += 1
	else:
		fase_atual = 0
	fases[fase_atual].executar()
