class_name CardManager extends CardContainer

var current_carta: Carta
var current_parent: CardContainer
var new_parent: CardContainer

func on_holding_card(carta: Carta, container: CardContainer) -> void:
	current_carta = carta
	current_parent = container

	carta.fim_do_arrasto.connect(on_grab_ended.bind(carta))


func on_grab_ended(carta: Carta) -> void:
	carta.fim_do_arrasto.disconnect(on_grab_ended.bind(carta))

	if new_parent == null:
		current_parent.canceled_card_move(carta)
		return # aqui a carta tem que voltar pro pai original
	
	if new_parent != current_parent:
		current_parent.remove_child(carta)
		new_parent.add_child(carta)


func on_carta_over_container(carta: Carta, container: CardContainer) -> void:
	if not container.can_receive_cards:
		return

	if carta != current_carta:
		return

	if container != current_parent:
		new_parent = container
		return

	if container == current_parent:
		current_parent.received_own_card(carta)


func on_carta_leaving_container(carta: Carta, container: CardContainer) -> void:
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

