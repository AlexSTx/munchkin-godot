extends Node

class_name Pilha

var _cartas : Array[Carta]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func escolherCarta() -> Carta:
	return _cartas.pop_back()
