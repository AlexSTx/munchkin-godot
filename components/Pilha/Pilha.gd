extends Node

class_name Pilha

var _cartas : Array[Carta]


func puxar_carta():
	print("draw_card")


func escolherCarta() -> Carta:
	return _cartas.pop_back()
