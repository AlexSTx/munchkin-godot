class_name CardManager extends Node

var current_carta: Carta
var current_parent: CardContainer
var new_parent: CardContainer

var left_curr_container : bool
var just_moved: bool


func reset_state() -> void:
	current_carta = null
	current_parent = null
	new_parent = null
	left_curr_container = false
	just_moved = false


func on_holding_card(carta: Carta, container: CardContainer) -> void:
	print("CARD MANAGER - on_holding_card")

	current_carta = carta
	current_parent = container
	left_curr_container = false
	just_moved = false

	carta.fim_do_arrasto.connect(on_grab_ended)


func on_grab_ended(carta: Carta) -> void:
	print("CARD MANAGER - on_grab_ended ", just_moved)

	if new_parent == null:
		if left_curr_container:
			current_parent.canceled_card_move(carta)
		else:
			current_parent.received_own_card(carta)
		
		carta.fim_do_arrasto.disconnect(on_grab_ended)
		return 
	
	if new_parent == current_parent:
		current_parent.received_own_card(carta)
		carta.fim_do_arrasto.disconnect(on_grab_ended)
		return

	if new_parent.accepts_card(carta):
		just_moved = true
		current_parent.remove_child(carta)
		new_parent.add_carta(carta)
	else:
		current_parent.canceled_card_move(carta)

	carta.fim_do_arrasto.disconnect(on_grab_ended)
	reset_state()


func on_carta_over_container(carta: Carta, container: CardContainer) -> void:
	print("CARD MANAGER - on_carta_over_container")
	if not container.can_receive_cards:
		return

	if carta != current_carta:
		return

	new_parent = container
	print(container)


func on_carta_leaving_container(carta: Carta, container: CardContainer) -> void:
	if just_moved:
		return 

	print("CARD MANAGER - on_carta_leaving_container")
	left_curr_container = true

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
