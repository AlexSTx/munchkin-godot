extends Restricao

class_name RestricaoRaca

# O nome da classe que satisfaz a restricao
@export var raca : String

func _init(p_raca : String = "") -> void:
	self.raca = p_raca

func satisfaz_condicao( alvo : Jogador ) -> bool:
	for raca in alvo.equipamentos._racas:
		if raca.titulo == self.raca:
			return true
	return false
