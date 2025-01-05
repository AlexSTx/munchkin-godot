class_name SlotJogador extends Slot

func accepts_card(carta: Carta) -> bool:
	return (carta is Pocao or carta is Habilidade) and satisfaz_cond(carta)
