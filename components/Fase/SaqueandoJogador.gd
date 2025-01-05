class_name SaqueandoJogador extends Fase

var pilhaCartas: Array[Carta]
var jogadores: Jogador

func _ready() -> void:
	#saqueiaJogador()
	pass

func saqueiaJogador() -> void:
	
	# 1° dar uma carta pra cada jogador do bolo e jogar resto fora
	for carta in jogador_atual.get_mao().cartas:
		jogadores.get_mao().add_carta(carta)
	# Zerar ouro, nível e demais itens
	jogador_atual.set_jogador(jogador_atual.get_nome(),jogador_atual.get_sexo())
	
	
