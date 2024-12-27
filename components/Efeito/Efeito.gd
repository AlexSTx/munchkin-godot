extends Resource

class_name Efeito

@export var restricoes : Array[Restricao]

func _init(e_restricoes : Array[Restricao] = []) -> void:
	self.restricoes = e_restricoes
	
func aplicar(alvo : Status) -> void:
	return
