extends Efeito

class_name EfeitoRemoverClasse

func aplicar( alvo : Object ) -> void:
	if not _pode_invocar(alvo): return
	
	if alvo is not Jogador: 
		return
	
	# TODO: Deixar o jogador escolher a classe a ser removida se ele for super munchkin
	(alvo as Jogador).equipamentos._classes.pop_front()
	(alvo as Jogador).status.recalcular()
