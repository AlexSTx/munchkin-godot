extends Restricao

class_name RestricaoRaca

# O nome das classes que satisfazem a relacao
@export var racas : Array[String]

func _init(p_racas : Array[String] = []) -> void:
	self.racas = p_racas

# mock
# NÃO FUNCIONA
func satisfaz_condicao( alvo : Jogador ) -> bool:
	for cls in self.classes:
		if is_instance_of(alvo, cls):
			return true
	
	return false
