extends Restricao

class_name RestricaoClasse

# O nome das classes que satisfazem a restricao
@export var classes : Array[String]

func _init(p_classes : Array[String] = []) -> void:
	self.classes = p_classes

# mock
# NÃO FUNCIONA
func satisfaz_condicao( alvo : Jogador ) -> bool:
	for cls in self.classes:
		if is_instance_of(alvo, cls):
			return true
	
	return false
