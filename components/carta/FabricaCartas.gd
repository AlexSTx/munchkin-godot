extends Node

class_name FabricaCartas

var carta_scene: PackedScene = preload("res://components/carta/carta.tscn")

func criar_carta(dados_carta: Dictionary) -> Carta:
	var nova_carta = carta_scene.instantiate() as Carta
	
	# Configura a carta com os dados básicos
	nova_carta.nivel = dados_carta.nivel
	nova_carta.titulo = dados_carta.titulo
	nova_carta.descricao = dados_carta.descricao
	
	# Carrega a imagem
	if ResourceLoader.exists(dados_carta.imagem):
		var imagem = load(dados_carta.imagem) as Texture2D
		nova_carta.setSprite(imagem)
	return nova_carta
