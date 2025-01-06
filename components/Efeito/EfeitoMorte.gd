class_name EfeitoMorte extends Efeito

func aplicar( alvo : Object ) -> void:
	Partida.get_turno()._trocar_de_fase("SaqueandoJogador", {})
