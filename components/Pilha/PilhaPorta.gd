extends "res://components/Pilha/Pilha.gd"

class_name PilhaPorta

func criar_pilha_inicial() -> void:
	var cartas = FactoryCarta.criar_cartas_da_pilha("PORTA")
	self.cartas_na_pilha = cartas
	MASK_COLLISION_PILHA = 4
