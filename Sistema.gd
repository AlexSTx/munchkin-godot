extends Node

var _jogadores_cadastrados: Array

func cadastra(nome: String):
	_jogadores_cadastrados.append(nome)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
