extends Node

class_name Turno

var indice_jogador_atual: int #indice do jogador atual na lista de jogadores em Partida
var fase_atual: int 
var fases: Array[Fase]

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_turno() -> void:
	indice_jogador_atual = 0
	#fases = [Preparo.new()]
	#fase_atual = 0
	#if indice_jogador_atual < Partida.get_jogadores().size():
	#	fases[fase_atual].set_jogador_atual(Partida.get_jogadores()[indice_jogador_atual])
	var preparo = preload("res://scenes/Preparo.tscn").instantiate()
	add_child(preparo) # Adicionar novas fases aqui

func passar_fase() -> void:
	var lista_jogadores = Partida.get_jogadores()
	#passa pra próxima fase
	if fase_atual < fases.size()-1:
		fase_atual += 1
	#caso a fase seja a ultima, muda o jogador e volta pra fase inicial (Preparo)
	else:
		fase_atual = 0
		if indice_jogador_atual < lista_jogadores.size()-1:
			indice_jogador_atual += 1
		else:
			indice_jogador_atual = 0
	fases[fase_atual].set_jogador_atual(lista_jogadores[indice_jogador_atual])
	fases[fase_atual].executar() # ideia pro executar(): tornar nó visivel (e usar o _process() dele pra alterar
								 # as labels baseadas no jogador atual, setado na linha de cima)

func get_jogador_atual() -> Jogador:
	return Partida.get_jogadores()[indice_jogador_atual]
