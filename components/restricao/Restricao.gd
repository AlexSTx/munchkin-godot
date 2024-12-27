extends Resource

class_name Restricao

func satisfaz_restricao(alvo : Object) -> bool:
	if "status" not in alvo:
		return false
	return true
