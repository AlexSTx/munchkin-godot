class_name CardContainer extends Node2D

signal holding_card(carta: Carta, container: CardContainer)
signal carta_left(carta: Carta, container: CardContainer)
signal carta_over(carta: Carta, container: CardContainer)

@onready var area: Area2D = $Area2D

var can_receive_cards := true


func set_signals_to_manager(manager: CardManager) -> void:
	holding_card.connect(manager.on_holding_card)
	carta_left.connect(manager.on_carta_leaving_container)
	carta_over.connect(manager.on_carta_over_container)


func on_card_grab_started(carta: Carta) -> void:
	print("CARD-CONTAINER : on_card_grab_started")
	holding_card.emit(carta, self)


func on_card_grab_ended(_carta: Carta) -> void:
	pass


func _on_area_entered(other_area: Area2D) -> void:
	print("CARD-CONTAINER : _on_area_entered")
	var carta = other_area.get_parent() as CartaArrastavel
	if not carta:
		return
	
	carta_over.emit(carta, self)
	

func _on_area_exited(other_area: Area2D) -> void:
	print("CARD-CONTAINER : _on_area_exited")
	var carta = other_area.get_parent() as CartaArrastavel
	if not carta:
		return
	
	carta_left.emit(carta, self)


func received_own_card(_carta: Carta) -> void:
	pass


func canceled_card_move(_carta: Carta) -> void:
	pass


func add_carta(carta: Carta) -> void:
	print("CARD-CONTAINER : add_carta")
	carta.inicia_arrasto.connect(on_card_grab_started)
	carta.fim_do_arrasto.connect(on_card_grab_ended)


func _ready() -> void:
	area.area_entered.connect(_on_area_entered)
	area.area_exited.connect(_on_area_exited)


func disable_container() -> void:
	can_receive_cards = false


func enable_container() -> void:
	can_receive_cards = true


func _process(_delta: float) -> void:
	pass
