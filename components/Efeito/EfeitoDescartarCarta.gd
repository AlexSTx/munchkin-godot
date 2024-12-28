extends Efeito

class_name EfeitoDescartarCarta

signal descartar_carta(jogador : Jogador, num_cartas : int)

@export var num_cartas : int

func _init(p_restricoes : Array[Restricao] = [], p_num_cartas : int = 1) -> void:
	super(p_restricoes)
	self.num_cartas = p_num_cartas

# Nesse caso, o alvo é o monstro que queremos invocar no combate
func aplicar( alvo : Object ) -> void:
	super(alvo)
	
	if alvo is not Jogador:
		return
	
	descartar_carta.emit(alvo as Jogador, self.num_cartas)
