class_name SlotArmadura extends Slot

func accepts_card(carta: Carta) -> bool:
	return carta is Armadura and satisfaz_cond(carta)
