extends Restricao

class_name RestricaoClasse

# O nome da classe que satisfaz a restricao
@export var classe : String
@export var inverso : bool

func _init(p_classe : String = "", p_inverso : bool = false) -> void:
	self.classe = p_classe
	self.inverso = p_inverso

func satisfaz_restricao( alvo : Object ) -> bool:
	if alvo is not Jogador: 
		return false
	for cls in (alvo as Jogador).get_inventario()._classes:
		if cls.titulo == self.classe: 
			return true if not inverso else false
	return false if not inverso else true
