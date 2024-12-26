extends Node2D
class_name Mao

const MASK_COLLISION = 1
const MASK_COLLISION_SLOT = 2

# Permite adicionar um componente (cena) qualquer para ser usado pelo script através
# do inspetor da Godot (painel do lado direito ao selecionar Node com este script)
@export var carta: PackedScene
@export var sprites: Array[Texture2D]

var card_being_dragged
var screen_size
var is_hovering_on_card
func _ready() -> void:
	screen_size = get_viewport_rect().size
#func pegarCartaNova() -> Carta:
#	# instancia um componente que foi adicionado no painel direito pelo inspetor
#	var instancia: Carta = carta.instantiate()
#	instancia.setSprite(sprites.pop_front())
#	return instancia
	
func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		# clamp permite definir um minimo e o maximo, fazendo com que a carta nn passe da borda
		card_being_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x),
		clamp(mouse_pos.y,0,screen_size.y))
		
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var carta = raycast_check_for_card()
		if event.pressed:
			if carta:
				card_being_dragged = carta
			else:
				card_being_dragged = null
		else:  # Liberação do botão
			var card_slot_found= raycast_check_for_card_slot()
			if card_slot_found and not card_slot_found.card_in_slot:
				card_being_dragged.position = card_slot_found.position
				card_being_dragged.get_node("Area2D/CollisionShape2D").disabled = true
				card_slot_found.card_in_slot = true
			card_being_dragged = null
			
				
func connect_card_signals(carta):
	carta.connect("hovered", on_hovered_over_card)
	carta.connect("hovered_off", on_hovered_off_card)


func on_hovered_over_card(carta):
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(carta, true)
	
func on_hovered_off_card(carta):
	highlight_card(carta, false)
	var new_card_hovered = raycast_check_for_card()
	if new_card_hovered:
		highlight_card(new_card_hovered, true)
	else:
		is_hovering_on_card = false


func highlight_card(carta, hovered):
	if hovered:
		carta.scale = Vector2(1.05, 1.05)
		carta.z_index = 2
	else:
		carta.scale = Vector2(1, 1)
		carta.z_index = 1


func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas=true
	parameters.collision_mask = MASK_COLLISION
	var result = space_state.intersect_point(parameters)
	if result.size()>0:
		
		return get_card_with_highest_z_index(result)
		
	print("cheguei aqui")
	return null

func raycast_check_for_card_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas=true
	parameters.collision_mask = MASK_COLLISION_SLOT
	var result = space_state.intersect_point(parameters)
	if result.size()>0:
		
		return result[0].collider.get_parent()
		
	print("cheguei aqui")
	return null

# função pra sempre arrastar a carta que tiver no topo
func get_card_with_highest_z_index(cartas):
	print (cartas.size())
	var highest_z_card = cartas[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	
	#loop pelo resto das cartas pra saber qual está mais na frente
	for i in range (1, cartas.size()):
		var current_card = cartas[i].collider.get_parent()
		if current_card.z_index > highest_z_index:
			highest_z_card = current_card
			highest_z_index = current_card.z_index
	return highest_z_card
		
