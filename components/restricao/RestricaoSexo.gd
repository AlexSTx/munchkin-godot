extends Restricao

class_name RestricaoSexo

@export var sexo : String

func _init(p_sexo : String = "Masculino") -> void:
	self.sexo = p_sexo 

func satisfaz_restricao( alvo: Object ) -> bool:
	if alvo is not Jogador:
		return false
	
	return (alvo as Jogador).get_sexo() == self.sexo
