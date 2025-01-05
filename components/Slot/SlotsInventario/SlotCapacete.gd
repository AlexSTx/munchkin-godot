class_name SlotCapacete extends Slot

func accepts_card(carta: Carta) -> bool:
	return carta is Capacete and satisfaz_cond(carta)
