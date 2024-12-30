extends Node

var _jogadores: Array[Jogador]
var _turno: Turno
#var _mesa: Mesa

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_Partida(jogadores: Array[String]) -> void:
	var cena_jogador_host = preload("res://scenes/jogador_host.tscn")
	var cena_jogador = preload("res://scenes/jogador.tscn")
	#cria o jogado host e os outros players
	for n in jogadores.size():
		if n == 0:
			_jogadores.append(cena_jogador_host.instantiate())
			_jogadores[0].set_jogador(jogadores[0])
		else:
			_jogadores.append(cena_jogador.instantiate())
			_jogadores[n].set_jogador(jogadores[n])
	
	_turno = preload("res://scenes/turno.tscn").instantiate()
	#_mesa = preload("res://scenes/mesa.tscn").instantiate()
	
	#add_child(_mesa)
	for jogador: Jogador in _jogadores:
		add_child(jogador)
		
	_jogadores[0].set_jogador_host()
	add_child(_turno)

#func get_mesa() -> Mesa:
	#return _mesa

func get_jogadores() -> Array:
	return _jogadores

func get_turno() -> Turno:
	return _turno
