class_name SlotItem extends Slot

func accepts_card(carta: Carta) -> bool:
	return carta is Item and carta is not Equipamento
