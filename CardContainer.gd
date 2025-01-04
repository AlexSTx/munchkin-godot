class_name CardContainer extends Node

signal holding_card(carta: Carta, container: CardContainer)
signal carta_left(carta: Carta, container: CardContainer)
signal carta_over(carta: Carta, container: CardContainer)

@onready var area = $Area2D

func on_grab_started(carta: Carta) -> void:
	holding_card.emit(carta, self)


func _on_area_entered(other_area: Area2D) -> void:
	var carta = other_area.get_parent() as CartaArrastavel
	if not carta:
		return
	
	carta_over.emit(carta, self)
	

func _on_area_exited(other_area: Area2D) -> void:
	var carta = other_area.get_parent() as CartaArrastavel
	if not carta:
		return
	
	carta_left.emit(carta, self)


func _ready() -> void:
	area.area_entered.connect(_on_area_entered)
	area.area_exited.connect(_on_area_exited)


func _process(delta: float) -> void:
	pass
