class_name SlotRaca extends Slot

func accepts_card(carta: Carta) -> bool:
	return carta is Raca and satisfaz_cond(carta)

