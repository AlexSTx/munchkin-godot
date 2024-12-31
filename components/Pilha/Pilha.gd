extends Node2D
class_name Pilha

signal carta_puxada(carta: Carta)

@export var carta_scene: PackedScene = preload("res://components/carta/carta.tscn")
@export var sprites: Array[Texture2D]

@export var cartas_na_pilha: Array[Carta] = []
var mao_ref: Mao

func _ready() -> void:
	pass

# Override em cada subclasse de pilha
func criar_pilha_inicial() -> void:
	pass

func set_pilha() -> void:
	mao_ref = Partida.get_jogadores()[0].get_mao()
	criar_pilha_inicial()

func puxar_carta() -> void:
	if cartas_na_pilha.size() > 0:
		var carta = cartas_na_pilha.pop_back()
		remove_child(carta)
		mao_ref.add_child(carta)
		mao_ref.add_carta_para_mao(carta)
		carta.visible = true
		emit_signal("carta_puxada", carta)
