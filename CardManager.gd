class_name CardManager extends Node

var current_carta: Carta
var current_parent: Node
var new_parent: Node

func on_holding_card(carta: Carta, container: Node) -> void:
	current_carta = carta
	current_parent = container


func on_grab_ended(carta: Carta) -> void:
	if new_parent == null:
		return # aqui a carta tem que voltar pro pai original
	
	if new_parent != current_parent:
		current_parent.remove_child(carta)
		new_parent.add_child(carta)


func on_carta_over_something(carta: Carta, container: Node) -> void:
	if carta != current_carta:
		return

	if container != current_parent:
		new_parent = container


func on_carta_leaving_something(carta: Carta, container: Node) -> void:
	if carta != current_carta:
		return

	if container == current_parent:
		return
	
	if container == new_parent:
		new_parent = null


func _ready() -> void:
	pass 


func _process(_delta: float) -> void:
	pass

