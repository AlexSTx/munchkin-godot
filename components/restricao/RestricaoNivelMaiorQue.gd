extends Restricao

class_name RestricaoNivelMaiorQue

@export var limite : int

func _init(p_limite : int = 1) -> void:
	self.limite = p_limite 

func satisfaz_restricao( alvo: Object ):
	var status = alvo.get("status") as StatusEfetivo
	return status.nivel_efetivo > limite
