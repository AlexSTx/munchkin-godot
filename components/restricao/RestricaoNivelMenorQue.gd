extends Restricao

class_name RestricaoNivelMenorQue

@export var limite : int

func _init(p_limite : int = 1) -> void:
	self.limite = p_limite 

func satisfaz_condicao( alvo: Object ):
	var status = alvo.get("status") as StatusEfetivo
	return status.nivel_efetivo < limite
