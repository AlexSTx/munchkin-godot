class_name PilhaTesouro extends Pilha

func criar_pilha_inicial() -> void:
	self.cartas = FactoryCarta.criar_cartas_da_pilha("TESOURO")
