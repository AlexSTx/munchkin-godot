class_name PilhaPorta extends Pilha

func criar_pilha_inicial() -> void:
	self.cartas = FactoryCarta.criar_cartas_da_pilha("PORTA")
