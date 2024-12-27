extends Restricao

class_name RestricaoClasse

# O nome da classe que satisfaz a restricao
@export var classe : String

func _init(p_classe : String = "") -> void:
	self.classe = classe

func satisfaz_condicao( alvo : Jogador ) -> bool:
	for classe in alvo.equipamentos._classe:
		if classe.titulo == self.classe:
			return true
	return false
