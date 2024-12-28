extends Efeito

class_name EfeitoEscaparCombate

signal escapar_combate(jogador : Jogador)


func aplicar( alvo : Object ) -> void:
	super(alvo)
	
	if alvo is not Jogador:
		return
	
	escapar_combate.emit(alvo as Jogador)
