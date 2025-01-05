class_name CardManager extends CardContainer

var current_carta: Carta
var current_parent: CardContainer
var new_parent: CardContainer

var left_curr_container : bool

func on_holding_card(carta: Carta, container: CardContainer) -> void:
	print("CARD MANAGER - on_holding_card")

	current_carta = carta
	current_parent = container
	left_curr_container = false

	carta.fim_do_arrasto.connect(on_grab_ended)


func on_grab_ended(carta: Carta) -> void:
	print("CARD MANAGER - on_grab_ended")
	carta.fim_do_arrasto.disconnect(on_grab_ended)

	if new_parent == null:
		if left_curr_container:
			current_parent.canceled_card_move(carta)
		else:
			current_parent.received_own_card(carta)
		return 
	
	if new_parent == current_parent:
		current_parent.received_own_card(carta)
		return

	print("Novo container ----> ")
	new_parent.print_tree_pretty()

	current_parent.remove_child(carta)
	new_parent.add_carta(carta)


func on_carta_over_container(carta: Carta, container: CardContainer) -> void:
	print("CARD MANAGER - on_carta_over_container")
	if not container.can_receive_cards:
		return

	if carta != current_carta:
		return

	new_parent = container
	print(container)


func on_carta_leaving_container(carta: Carta, container: CardContainer) -> void:
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
