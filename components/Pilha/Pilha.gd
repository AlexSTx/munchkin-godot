extends Node

class_name Pilha
const CAMINHO_CENA_CARTA = "res://components/carta/carta.tscn"
var _cartas = ["Exodia", "Exodia", "Exodia"]

func puxar_carta():
	print("chegou aqui")
	var carta_puxada = _cartas[0]
	print("chegou aqui")
	_cartas.erase(carta_puxada)
	if _cartas.size()==0:
		$Area2D/CollisionShape2D.disabled=true
		$Sprite2D.visible = false
		
	var cena_carta = preload(CAMINHO_CENA_CARTA)
	var nova_carta = cena_carta.instantiate()
	$"../Mao".add_child(nova_carta)
	nova_carta.name = "Carta"
	$"../Mao".add_carta_para_mao(nova_carta)


func escolherCarta() -> Carta:
	return _cartas.pop_back()
