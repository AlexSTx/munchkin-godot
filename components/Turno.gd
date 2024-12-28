extends Node

class_name Turno

var jogador_atual: int #indice do jogador atual na lista de jogadores em Partida
var fase_atual: int 
var fases: Array

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_turno() -> void:
	jogador_atual = 0
	fase_atual = 0
	fases.append(preload("res://scenes/FasePreparo.tscn").instantiate())
	fases.append(preload("res://scenes/FaseBatalha.tscn").instantiate())
	fases.append(preload("res://scenes/FaseFinal.tscn").instantiate())

	add_child(fases[0]) # Adicionar novas fases aqui
	
	fases[fase_atual].set_fase()

func passar_fase() -> void:
	print("Passou de fase")
	remove_child(fases[fase_atual])
	#fases[fase_atual].visible = false
	var lista_jogadores = Partida.get_jogadores()
	#passa pra próxima fase
	if fase_atual < fases.size()-1:
		fase_atual += 1
	#caso a fase seja a ultima, muda o jogador e volta pra fase inicial (Preparo)
	else:
		fase_atual = 0
		#if indice_jogador_atual < lista_jogadores.size()-1:
		#	indice_jogador_atual += 1
		#else:
		#	indice_jogador_atual = 0
	add_child(fases[fase_atual])
	fases[fase_atual].set_jogador_atual(get_jogador_atual())
	fases[fase_atual].set_fase()
	#fases[fase_atual].visible = true

func get_jogador_atual() -> Jogador:
	return Partida.get_jogadores()[jogador_atual]
