extends Node

class_name CartasDatabase


# Tornando a variável static também
static var _instance = null

static func get_instance() -> CartasDatabase:
	return _instance

# Dicionário único para todas as cartas
var cartas: Dictionary = {}

func _init():
	if _instance == null:
		_instance = self
	_carregar_cartas()

func get_carta_aleatoria() -> Dictionary:
	
	var keys = cartas.keys()
	var random_key = keys[randi() % keys.size()]
	return cartas[random_key]

func _carregar_cartas() -> void:
	cartas = {
		"Espada": {
			"titulo": "Espada do Destino",
			"descricao": "Uma poderosa espada que concede +2 de ataque.",
			"nivel": 2,
			"valor": 100,
			"imagem": "res://assets/cartas/bakugan.jpeg"
		},
		"Escudo": {
			"titulo": "Escudo Divino",
			"descricao": "Um escudo que reduz dano em 50%.",
			"nivel": 3,
			"valor": 150,
			"imagem": "res://imagens/bakugan.jpeg"
		},
		"Poção": {
			"titulo": "Poção de Vida",
			"descricao": "Recupera 50 de vida.",
			"nivel": 1,
			"valor": 50,
			"imagem": "res://imagens/bakugan.jpeg"
		}
}
