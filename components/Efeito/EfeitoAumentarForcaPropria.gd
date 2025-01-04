extends Efeito

class_name EfeitoAumentarForcaPropria

# Essa classe é valida somente com monstro

@export var valor : int
var monstro : Monstro

func _init(p_monstro : Monstro, p_restricoes : Array[Restricao] = [], p_valor : int = 1) -> void:
	super(p_restricoes)
	self.valor = p_valor
	self.monstro = p_monstro


func aplicar( alvo : Object = self.monstro) -> void:
	# Péssima solução, mas funciona
	super(alvo)
	
	if alvo != self.monstro:
		print("O efeito AumentarForçaPropria só deve ser utilizado no monstro atual, ignorando alvo " + alvo.name)
		
	
	self.monstro.status.alterar_nivel_efetivo(self.valor)
