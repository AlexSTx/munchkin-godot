extends Node

var _jogadores: Array
var _turno: Turno
var _mesa: Mesa

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_Partida() -> void:
	_jogadores.append(preload("res://scenes/jogador_host.tscn").instantiate())
	add_child(_jogadores[0])
	
	if Sistema._jogadores_cadastrados.size() > 0:
		_jogadores[0].set_nome(Sistema._jogadores_cadastrados[0])
		
	_turno = preload("res://scenes/turno.tscn").instantiate()
	add_child(_turno)


func get_mesa() -> Mesa:
	return _mesa

func get_jogadores() -> Array:
	return _jogadores

func get_turno() -> Turno:
	return _turno
