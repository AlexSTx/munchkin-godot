extends Node2D
class_name Mao

const MASK_COLLISION = 1
const MASK_COLLISION_SLOT = 2
const CARD_SCENE_PATH = "res://components/carta/carta.tscn"
const CARTA_LARGURA = 200
const MAO_POS_Y = 890
var tela_centro_x
# Permite adicionar um componente (cena) qualquer para ser usado pelo script através
# do inspetor da Godot (painel do lado direito ao selecionar Node com este script)
@export var carta: PackedScene
@export var sprites: Array[Texture2D]
var limite=5
var cartas_mao = []
var card_being_dragged
var screen_size
var is_hovering_on_card
func _ready() -> void:
	tela_centro_x = get_viewport().size.x / 4
	screen_size = get_viewport_rect().size
	var card_scene = preload(CARD_SCENE_PATH)
	for i in range (limite):
		var nova_carta = card_scene.instantiate()
		add_child(nova_carta)
		nova_carta.name = "Carta"
		add_carta_para_mao(nova_carta)
		
func add_carta_para_mao(carta_n):
	if carta_n not in cartas_mao:
		cartas_mao.insert(0,carta_n)
		atualizar_pos_mao(carta_n)
	else:
		animar_carta_para_pos(carta_n, carta_n.pos_inicial_mao)

func remover_carta_da_mao(carta_n):
	if carta_n in cartas_mao:
		cartas_mao.erase(carta_n)
		atualizar_pos_mao(carta_n)

	
func atualizar_pos_mao(carta_n):
	for i in range(cartas_mao.size()):
		print (cartas_mao.size())
		#calcula a posição da nova carta a partir do index passado
		var nova_pos = Vector2(calcular_pos_carta(i), MAO_POS_Y)
		if carta_n in cartas_mao:
			carta_n.pos_inicial_mao = nova_pos 
			animar_carta_para_pos(carta_n, nova_pos)

func calcular_pos_carta(index):
	var largura_total = cartas_mao.size()-1 * CARTA_LARGURA
	var x_offset = tela_centro_x + index * CARTA_LARGURA - largura_total
	return x_offset
	
func animar_carta_para_pos(carta_n, nova_pos):
	var tween = get_tree().create_tween()
	tween.tween_property(carta_n, "position", nova_pos, 0.1)
func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		# clamp permite definir um minimo e o maximo, fazendo com que a carta nn passe da borda
		card_being_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x),
		clamp(mouse_pos.y,0,screen_size.y))
		
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var carta = raycast_check_for_card()
			if carta:
				comecar_arraste(carta)
		else:
			if card_being_dragged:
				terminar_arraste()
			
			

func comecar_arraste(carta):
	card_being_dragged = carta

func terminar_arraste():
	var card_slot_found = raycast_check_for_card_slot()
	if card_slot_found and not card_slot_found.card_in_slot:
		remover_carta_da_mao(card_being_dragged)
		# carta solta em um slot vazio
		card_being_dragged.position = card_slot_found.position
		card_being_dragged.get_node("Area2D/CollisionShape2D").disabled = true
		card_slot_found.card_in_slot = true
	else:
		add_carta_para_mao(card_being_dragged)
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
		
