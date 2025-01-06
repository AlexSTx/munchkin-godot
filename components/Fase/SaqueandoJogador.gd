class_name SaqueandoJogador extends Fase

var cartas_saqueadas: Array[Carta]
var jogadores: Array[Jogador]

func _ready() -> void:
	#saqueiaJogador()
	pass

func saqueiaJogador(jogador: Jogador) -> void:
	
	cartas_saqueadas.append_array(jogador.get_mao().ser_saqueado())
	cartas_saqueadas.append_array(jogador.get_inventario().ser_saqueado_inventario())
	
	jogadores = Partida.get_jogadores()
	# 1° dar uma carta pra cada jogador do bolo e jogar resto fora
	for jog in jogadores:
		if jog != jogador and cartas_saqueadas.size() > 0:
			jog.get_mao().add_carta(cartas_saqueadas.pop_at(0))
