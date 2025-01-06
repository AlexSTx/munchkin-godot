class_name SlotEquipamentoMao extends Slot

func accepts_card(carta: Carta) -> bool:
	return carta is EquipamentoMao && not Partida._jogadores[0].get_inventario()._is_mao_cheia() and satisfaz_cond(carta)
