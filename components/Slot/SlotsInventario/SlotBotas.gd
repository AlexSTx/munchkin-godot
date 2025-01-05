class_name SlotBotas extends Slot

func accepts_card(carta: Carta) -> bool:
	return carta is Botas and satisfaz_cond(carta)
