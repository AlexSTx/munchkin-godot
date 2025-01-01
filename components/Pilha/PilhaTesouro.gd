extends "res://components/Pilha/Pilha.gd"

class_name PilhaTesouro

func criar_pilha_inicial() -> void:
	self.cartas_na_pilha = FactoryCarta.criar_cartas_da_pilha("TESOURO")
	MASK_COLLISION_PILHA = 5
