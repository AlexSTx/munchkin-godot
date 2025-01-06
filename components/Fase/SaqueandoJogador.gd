class_name SaqueandoJogador extends Fase

var cartas_saqueadas: Array[Carta]
var jogadores: Array[Jogador]

func _ready() -> void:
	#saqueiaJogador()
	pass

func saqueiaJogador() -> void:
	
	cartas_saqueadas.append_array(get_jogador_atual().get_mao().ser_saqueado())
	cartas_saqueadas.append_array(get_jogador_atual().get_inventario().ser_saqueado_inventario())
	
	get_jogador_atual().set_jogador()
	jogadores = Partida.get_jogadores()
	# 1° dar uma carta pra cada jogador do bolo e jogar resto fora
	for jog in jogadores:
		if jog != get_jogador_atual() and cartas_saqueadas.size() > 0:
			jog.get_mao().add_carta(cartas_saqueadas.pop_at(0))
