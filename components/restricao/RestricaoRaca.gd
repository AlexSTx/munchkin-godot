extends Restricao

class_name RestricaoRaca

# O nome da classe que satisfaz a restricao
@export var raca : String
@export var inverso : bool
func _init(p_raca : String = "", p_inverso : bool = false) -> void:
	self.raca = p_raca
	self.inverso = p_inverso

func satisfaz_restricao( alvo : Object ) -> bool:
	if alvo is not Jogador: 
		return false
	for rc in (alvo as Jogador).get_inventario()._racas:
		if rc.titulo == self.raca:
			return true if not inverso else false
	return false if not inverso else true
