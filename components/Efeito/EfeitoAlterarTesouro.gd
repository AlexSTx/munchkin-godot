extends Efeito

class_name EfeitoAlterarTesouro

@export var valor : int
# TODO: Refatorar para associar esse efeito ao monstro atual


func _init(p_restricoes : Array[Restricao] = [], p_valor : int = 1) -> void:
	super(p_restricoes)
	self.valor = p_valor

func aplicar( alvo : Object ) -> void:
	if not _pode_invocar(alvo): return
	
	if alvo is not Monstro:
		return
	
	#TODO: Colocar isso em uma função em Monstro
	(alvo as Monstro).tesouro += self.valor
