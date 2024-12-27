extends Efeito

class_name EfeitoRemoverRaca

func aplicar( alvo : Object ) -> void:
	super(alvo)
	
	if alvo is not Jogador: 
		return
	
	# TODO: Deixar o jogador escolher a raça a ser removida se ele for mestiço
	(alvo as Jogador).equipamentos._racas.pop_front()