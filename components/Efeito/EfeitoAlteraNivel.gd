extends Efeito

class_name EfeitoAlterarNivel

@export var valor : int

func _init(p_restricoes : Array[Restricao] = [], p_valor : int = 1) -> void:
	super(p_restricoes)
	self.valor = p_valor

func aplicar( alvo : Object ) -> void:
	super(alvo)
	var p : Jogador = alvo
	p.add_nivel(self.valor)
	
