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

func set_Partida(nomes_jogadores: Array[String]) -> void:
	_turno = load("res://scenes/turno.tscn").instantiate()
	#_mesa = load("res://scenes/mesa.tscn").instantiate()
	#add_child(_mesa)
	_instancia_jogadores(nomes_jogadores)
	_adiciona_e_seta_jogadores()
	add_child(_turno)

#func get_mesa() -> Mesa:
	#return _mesa

func get_jogadores() -> Array:
	return _jogadores

func get_turno() -> Turno:
	return _turno

func _instancia_jogadores(nomes: Array[String]) -> void:
	var cena_jogador_host = preload("res://scenes/jogador_host.tscn")
	var cena_jogador_oponente = preload("res://scenes/jogador_oponente.tscn")
	
	for n in nomes.size():
		if n == 0:
			_jogadores.append(cena_jogador_host.instantiate())
		else:
			_jogadores.append(cena_jogador_oponente.instantiate())
		_jogadores[n].set_jogador(nomes[n])

func _adiciona_e_seta_jogadores() -> void:
	var pos = 0.0
	for n in _jogadores.size():
		add_child(_jogadores[n])
		if n == 0:
			_jogadores[n].set_jogador_host()
		else:
			_jogadores[n].set_jogador_oponente()
			_jogadores[n].position.x = pos
			pos += 400.0
