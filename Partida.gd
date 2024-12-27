extends Node

var _jogadores: Array[Jogador]
var _turno: Turno
var _mesa: Mesa

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var host = preload("res://jogador_host.tscn").instantiate()
	print(host.nome)
	get_tree().current_scene.add_child(host)
	host.set_nome(Sistema._jogadores_cadastrados[0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
