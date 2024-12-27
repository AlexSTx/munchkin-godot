extends Node2D
class_name Mao

const MASK_COLLISION = 1
const MASK_COLLISION_SLOT = 2
const MASK_COLLISION_PILHA = 4
const CARTA_LARGURA = 200
const MAO_POS_Y = 890
var tela_centro_x
# Permite adicionar um componente (cena) qualquer para ser usado pelo script através
# do inspetor da Godot (painel do lado direito ao selecionar Node com este script)
@export var carta: PackedScene
@export var sprites: Array[Texture2D]
var limite=5
var cartas_mao = []
var carta_sendo_arrastada
var tela_tam
var is_hovering_on_card
func _ready() -> void:
	tela_centro_x = get_viewport().size.x / 4
	$"../GerenciadorInput".connect("mouse_esq_solto", mouse_esq_solto)
	tela_tam = get_viewport_rect().size
	
		
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

func mouse_esq_solto():
	if carta_sendo_arrastada:
		terminar_arraste()

	
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
	if carta_sendo_arrastada:
		var mouse_pos = get_global_mouse_position()
		# clamp permite definir um minimo e o maximo, fazendo com que a carta nn passe da borda
		carta_sendo_arrastada.position = Vector2(clamp(mouse_pos.x, 0, tela_tam.x),
		clamp(mouse_pos.y,0,tela_tam.y))
		
		
#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#var carta = raycast_check_for_card()
			#if carta:
				#comecar_arraste(carta)
		#else:
			#if carta_sendo_arrastada:
				#terminar_arraste()
			#
			

func comecar_arraste(carta):
	carta_sendo_arrastada = carta

func terminar_arraste():
	var achou_slot = raycast_check_for_card_slot()
	if achou_slot and not achou_slot.carta_no_slot:
		remover_carta_da_mao(carta_sendo_arrastada)
		# carta solta em um slot vazio
		carta_sendo_arrastada.position = achou_slot.position
		carta_sendo_arrastada.get_node("Area2D/CollisionShape2D").disabled = true
		achou_slot.carta_no_slot = true
	else:
		add_carta_para_mao(carta_sendo_arrastada)
	carta_sendo_arrastada = null

			
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
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position = get_global_mouse_position()
	parametros.collide_with_areas=true
	parametros.collision_mask = MASK_COLLISION
	var result = space_state.intersect_point(parametros)
	if result.size()>0:
		
		return get_carta_com_maior_z_index(result)
		
	print("cheguei aqui")
	return null

func raycast_check_for_card_slot():
	var space_state = get_world_2d().direct_space_state
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position = get_global_mouse_position()
	parametros.collide_with_areas=true
	parametros.collision_mask = MASK_COLLISION_SLOT
	var result = space_state.intersect_point(parametros)
	if result.size()>0:
		
		return result[0].collider.get_parent()
		

	return null

# função pra sempre arrastar a carta que tiver no topo
func get_carta_com_maior_z_index(cartas):
	print (cartas.size())
	var carta_com_maior_z = cartas[0].collider.get_parent()
	var maior_z_index = carta_com_maior_z.z_index
	
	#loop pelo resto das cartas pra saber qual está mais na frente
	for i in range (1, cartas.size()):
		var carta_atual = cartas[i].collider.get_parent()
		if carta_atual.z_index >maior_z_index:
			carta_com_maior_z = carta_atual
			maior_z_index = carta_atual.z_index
	return carta_com_maior_z
		
