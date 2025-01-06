class_name SaqueandoJogador extends Fase

var cartas_saqueadas: Array[Carta]
var jogadores: Array[Jogador]

func enter(previous_fase_path: String, data := {}) -> void:
	if fase_bot():
		await get_tree().create_timer(2.0).timeout
		finished.emit("Preparo", {})
	else:
		saqueiaJogador(_jogador_atual)
		finished.emit("Preparo", {})

func saqueiaJogador(jogador: Jogador) -> void:
	
	cartas_saqueadas.append_array(jogador.get_mao().ser_saqueado())
	cartas_saqueadas.append_array(jogador.get_inventario().ser_saqueado_inventario())
	
	jogadores = Partida.get_jogadores()
	# 1° dar uma carta pra cada jogador do bolo e jogar resto fora
	for jog in jogadores:
		if jog != jogador and cartas_saqueadas.size() > 0:
			jog.get_mao().add_carta(cartas_saqueadas.pop_at(0))

	_jogador_atual.set_nivel(1)
	_jogador_atual.set_jogador(_jogador_atual.get_nome(),_jogador_atual.get_sexo())
