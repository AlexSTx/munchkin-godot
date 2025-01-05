extends Resource


# DIZ RESPEITO SOMENTE A UM EFEITO EM ESPECIFICO
class_name RestricaoNaoEquipavel

func satisfaz_restricao(alvo : Object) -> bool:
	if "status" not in alvo:
		return false
	return true