extends Resource

class_name Efeito

#TODO: Definir quando a função "aplicar" deve ser chamada

@export var permanente : bool
@export var restricoes : Array[Restricao]

func _init(p_restricoes : Array[Restricao] = [], p_permanente : bool = false) -> void:
	self.restricoes = p_restricoes
	self.permanente = p_permanente
	
func aplicar( alvo : Object ) -> void:
	if "status" not in alvo:
		print(alvo.to_string() + " não possui propriedade \"status\"")
		return
	for rest in self.restricoes:
		if rest.satisfaz_restricao(alvo):
			return
	return
