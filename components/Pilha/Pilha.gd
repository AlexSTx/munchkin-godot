extends Node2D
class_name Pilha

signal carta_puxada(carta: Carta)

@export var carta_scene: PackedScene = preload("res://components/carta/carta.tscn")
@export var sprites: Array[Texture2D]

var cartas_na_pilha: Array[Carta] = []
var mao_ref: Mao

func _ready() -> void:
	mao_ref = get_node("../Mao")
	criar_pilha_inicial()

func criar_pilha_inicial() -> void:
	# Exemplo de criação de algumas cartas
	var cartas_info = [
		{
			"texture": preload("res://assets/exodia.jpeg"), 
			"nivel": 1,
			"titulo": "Espada Longa",
			"descricao": "+3 de Bônus"
		},
		{
			"texture": preload("res://assets/bakugan.jpeg"), 
			"nivel": 2,
			"titulo": "Armadura de Couro",
			"descricao": "+2 de Defesa"
		},
		{
			"texture": preload("res://assets/bakugan.jpeg"), 
			"nivel": 2,
			"titulo": "Armadura de Couro",
			"descricao": "+2 de Defesa"
		}
	]
	
	for info in cartas_info:
		criar_nova_carta(info)

func criar_nova_carta(info: Dictionary) -> void:
	var nova_carta = carta_scene.instantiate() as Carta
	add_child(nova_carta)
	nova_carta.setup_card(
		info["texture"],
		info["nivel"],
		info["titulo"],
		info["descricao"]
	)
	nova_carta.visible = false
	cartas_na_pilha.append(nova_carta)


func puxar_carta() -> void:
	if cartas_na_pilha.size() > 0:
		var carta = cartas_na_pilha.pop_back()
		remove_child(carta)
		mao_ref.add_child(carta)
		mao_ref.add_carta_para_mao(carta)
		carta.visible = true
		emit_signal("carta_puxada", carta)
