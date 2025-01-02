class_name Mesa extends Node2D

var _tesouro: PilhaTesouro
var _porta: PilhaPorta

func set_mesa() -> void:
	_tesouro = PilhaTesouro.new()
	_porta = PilhaPorta.new()

	_tesouro.name = "BaralhoTesouro"
	_porta.name = "BaralhoPorta"

	_tesouro.set_image(preload("res://assets/tesouro.png"))
	_porta.set_image(preload("res://assets/porta.png"))

	_tesouro.set_size(Vector2(200, 300))
	_porta.set_size(Vector2(200, 300))


	add_child(_tesouro)
	add_child(_porta)

	_tesouro.set_pilha()
	_porta.set_pilha()
		
	_tesouro.position = Vector2(147, 500)
	_porta.position = Vector2(360, 500)
	_porta.setup_highlight()

func get_porta() -> PilhaPorta:
	return _porta
	
func get_tesouro() -> PilhaTesouro:
	return _tesouro
