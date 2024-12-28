extends Node

var _jogadores: Array[Jogador]
var _turno: Turno
var _mesa: Mesa

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_Partida() -> void:
	var host = preload("res://scenes/jogador_host.tscn").instantiate()
	print(host.nome)
	add_child(host)
	if Sistema._jogadores_cadastrados.size() > 0:
		host.set_nome(Sistema._jogadores_cadastrados[0])
		
	_turno = Turno.new()
	add_child(_turno)
	_turno.set_turno()

func get_mesa() -> Mesa:
	return _mesa

func get_jogadores() -> Array:
	return _jogadores
