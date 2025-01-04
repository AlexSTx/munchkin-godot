class_name PilhaTesouro extends Pilha

func _criar_pilha_inicial() -> void:
	self._cartas = FactoryCarta.criar_cartas_da_pilha("TESOURO")
