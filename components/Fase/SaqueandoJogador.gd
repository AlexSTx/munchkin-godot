class_name SaqueandoJogador extends Fase

var _cartas_saqueadas: Array[Carta]
var _jogadores: Array[Jogador]

func enter(previous_fase_path: String, data := {}) -> void:
	if fase_bot():
		await get_tree().create_timer(2.0).timeout
		finished.emit("Preparo", {})
	else:
		saqueiaJogador(_jogador_atual)
		exit()

func exit() -> void:
	finished.emit("Preparo", {})

func saqueiaJogador(jogador: Jogador) -> void:
	
	_cartas_saqueadas.append_array(jogador.get_mao().ser_saqueado())
	_cartas_saqueadas.append_array(jogador.get_inventario().ser_saqueado_inventario())
	
	_jogadores = Partida.get_jogadores()
	for jog in _jogadores:
		if jog != jogador and _cartas_saqueadas.size() > 0:
			jog.get_mao().add_carta(_cartas_saqueadas.pop_at(0))

	_jogador_atual.set_nivel(1)
	_jogador_atual.set_jogador(_jogador_atual.get_nome(),_jogador_atual.get_sexo())
