extends Efeito

class_name EfeitoAlterarNivel

@export var valor : int

func _init(p_restricoes : Array[Restricao] = [], p_valor : int = 1) -> void:
	super(p_restricoes)
	self.valor = p_valor

func aplicar( alvo : Object ) -> void:
	super(alvo)
	var p = alvo as Jogador
	#TODO: Colocar essa função dentro de jogador
	p.nivel += valor
	if p.nivel < 1:
		p.nivel = 1
	
