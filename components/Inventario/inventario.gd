extends Node2D

class_name Inventario

var _cartas : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_cartas = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func adicionar_carta(carta : Carta) -> void:
	_cartas.append(carta)

func ativar_carta(carta : Carta) -> void:
	for efeito in carta.efeitos:
		efeito.aplicar()

func dar_carta(jogador : Jogador, carta : Carta) -> void:
	pass
