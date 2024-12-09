extends Node2D
class_name Mao

# Permite adicionar um componente (cena) qualquer para ser usado pelo script através
# do inspetor da Godot (painel do lado direito ao selecionar Node com este script)
@export var carta: PackedScene
@export var sprites: Array[Texture2D]

func pegarCartaNova() -> Carta:
	# instancia um componente que foi adicionado no painel direito pelo inspetor
	var instancia: Carta = carta.instantiate()
	instancia.setSprite(sprites.pop_front())
	return instancia
