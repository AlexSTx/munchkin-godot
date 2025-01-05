extends Resource

class_name Efeito

#TODO: Definir quando a função "aplicar" deve ser chamada

@export var permanente : bool
@export var restricoes : Array[Restricao]

func _init(p_restricoes : Array[Restricao] = [], p_permanente : bool = false) -> void:
	self.restricoes = p_restricoes
	self.permanente = p_permanente

func _pode_invocar(alvo : Object) -> bool:
	if "status" not in alvo:
		print(alvo.to_string() + " não possui propriedade \"status\"")
		return false
	if self.restricoes.is_empty():
		return true
	else:
		for rest in self.restricoes:
			if rest.satisfaz_restricao(alvo):
				return true
		return false

func aplicar( alvo : Object ) -> void:
	return
