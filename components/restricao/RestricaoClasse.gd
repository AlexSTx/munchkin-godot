extends Restricao

class_name RestricaoClasse

# O nome da classe que satisfaz a restricao
@export var classe : String
@export var inverso : bool

func _init(p_classe : String = "", p_inverso : bool = false) -> void:
	self.classe = p_classe
	self.inverso = p_inverso

func satisfaz_condicao( alvo : Jogador ) -> bool:
	for classe in alvo.equipamentos._classe:
		if classe.titulo == self.classe:
			return true if not inverso else false
	return false if not inverso else true
