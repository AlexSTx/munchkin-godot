class_name Mesa extends Node2D

var _tesouro: PilhaTesouro
var _porta: PilhaPorta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_mesa() -> void:
	var cena_pilha_tesouro = preload("res://scenes/PilhaTesouro.tscn").instantiate()
	var cena_pilha_porta = preload("res://scenes/PilhaPorta.tscn").instantiate()
	_tesouro = cena_pilha_tesouro
	_porta = cena_pilha_porta
	
	add_child(_tesouro)
	add_child(_porta)
	
	_tesouro.set_pilha()
	_porta.set_pilha()
	
	_tesouro.position = Vector2(147, 500)
	_porta.position = Vector2(344, 500)

func _process(delta: float) -> void:
	pass

func get_porta() -> PilhaPorta:
	return _porta
	
func get_tesouro() -> PilhaTesouro:
	return _tesouro
