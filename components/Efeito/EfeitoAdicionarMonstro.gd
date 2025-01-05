extends Efeito

class_name EfeitoAdicionarMonstro

#TODO: Determinar a forma correta de emitir e responder ao sinal de invocar um monstro para a batalha
signal invocar_monstro(monstro : Monstro)

# Nesse caso, o alvo é o monstro que queremos invocar no combate
func aplicar( alvo : Object ) -> void:
	if not _pode_invocar(alvo): return
	
	if alvo is not Monstro:
		print(alvo.to_string() + " não é um monstro que pode ser invocado")
	
	invocar_monstro.emit(alvo)
