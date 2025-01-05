extends Efeito

class_name EfeitoComprarCarta

#TODO: Determinar a forma correta de emitir e responder ao sinal de invocar um monstro para a batalha

#TODO: Adicionar Especificação de pilha

signal comprar_carta(jogador : Jogador, num_cartas : int)

@export var num_cartas : int

func _init(p_restricoes : Array[Restricao] = [], p_num_cartas : int = 1) -> void:
	super(p_restricoes)
	self.num_cartas = p_num_cartas

# Nesse caso, o alvo é o monstro que queremos invocar no combate
func aplicar( alvo : Object ) -> void:
	if not _pode_invocar(alvo): return
	
	if alvo is not Jogador:
		return
	
	comprar_carta.emit(alvo as Jogador, self.num_cartas)
