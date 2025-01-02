class_name Mao2 extends Node2D

const MASK_COLLISION = 1
const MASK_COLLISION_SLOT = 2
const MASK_COLLISION_PILHA = 4
const CARTA_LARGURA = 200
const MAO_POS_Y = 900

var cartas: Array[Carta] = []
var carta_sendo_arrastada: Carta
var is_hovering_on_card: bool = false

@onready var limite_cartas = 5

var area : Area2D

func _ready() -> void:
	pass


func add_carta_para_mao(carta: Carta) -> void:
	if carta not in cartas:
		cartas.insert(0, carta)
		print(cartas.size())
		atualizar_pos_mao()
	else:
		animar_carta_para_pos(carta, carta.pos_inicial_mao)

func remover_carta_da_mao(carta: Carta) -> void:
	if carta in cartas:
		cartas.erase(carta)
		atualizar_pos_mao()

func mouse_esq_solto() -> void:
	if carta_sendo_arrastada:
		terminar_arraste()

func atualizar_pos_mao() -> void:
	for i in range(cartas.size()):
		var carta = cartas[i]
		var nova_pos = Vector2(calcular_pos_carta(i), MAO_POS_Y)
		carta.pos_inicial_mao = nova_pos
		animar_carta_para_pos(carta, nova_pos)

func calcular_pos_carta(index: int) -> float:
	var tela_tam = get_viewport_rect().size
	var largura_total = (cartas.size()) * CARTA_LARGURA
	return tela_tam.x + index * CARTA_LARGURA - largura_total
	
func animar_carta_para_pos(carta: Carta, nova_pos: Vector2) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(carta, "position", nova_pos, 0.1)

func _process(_delta: float) -> void:
	var tela_tam = get_viewport_rect().size
	if carta_sendo_arrastada:
		var mouse_pos = get_global_mouse_position()
		carta_sendo_arrastada.position = Vector2(
			clamp(mouse_pos.x, 0, tela_tam.x),
			clamp(mouse_pos.y, 0, tela_tam.y)
		)

func comecar_arraste(carta: Carta) -> void:
	carta_sendo_arrastada = carta

func terminar_arraste() -> void:
	var achou_slot = raycast_check_for_card_slot()
	if achou_slot and not achou_slot.carta_no_slot:
		remover_carta_da_mao(carta_sendo_arrastada)
		carta_sendo_arrastada.position = achou_slot.position
		carta_sendo_arrastada.get_node("Area2D/CollisionShape2D").disabled = true
		achou_slot.carta_no_slot = true
	else:
		add_carta_para_mao(carta_sendo_arrastada)
	carta_sendo_arrastada = null

func connect_card_signals(carta: Carta) -> void:
	if not carta.is_connected("hovered", on_hovered_over_card):
		carta.connect("hovered", on_hovered_over_card)
	if not carta.is_connected("hovered_off", on_hovered_off_card):
		carta.connect("hovered_off", on_hovered_off_card)

func on_hovered_over_card(carta: Carta) -> void:
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(carta, true)

func on_hovered_off_card(carta: Carta) -> void:
	highlight_card(carta, false)
	var new_card_hovered = raycast_check_for_card()
	if new_card_hovered:
		highlight_card(new_card_hovered, true)
	else:
		is_hovering_on_card = false

func highlight_card(carta: Carta, hovered: bool) -> void:
	if hovered:
		carta.scale = Vector2(1.05, 1.05)
		carta.z_index = 2
	else:
		carta.scale = Vector2(1, 1)
		carta.z_index = 1

func raycast_check_for_card() -> Carta:
	var space_state = get_world_2d().direct_space_state
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position = get_global_mouse_position()
	parametros.collide_with_areas = true
	parametros.collision_mask = MASK_COLLISION
	var result = space_state.intersect_point(parametros)
	
	if result.size() > 0:
		return get_carta_com_maior_z_index(result)
	return null

func raycast_check_for_card_slot():
	var space_state = get_world_2d().direct_space_state
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position = get_global_mouse_position()
	parametros.collide_with_areas = true
	parametros.collision_mask = MASK_COLLISION_SLOT
	var result = space_state.intersect_point(parametros)
	
	if result.size() > 0:
		return result[0].collider.get_parent()
	return null

func get_carta_com_maior_z_index(cartas: Array) -> Carta:
	var carta_com_maior_z = cartas[0].collider.get_parent()
	var maior_z_index = carta_com_maior_z.z_index
	
	for i in range(1, cartas.size()):
		var carta_atual = cartas[i].collider.get_parent()
		if carta_atual.z_index > maior_z_index:
			carta_com_maior_z = carta_atual
			maior_z_index = carta_atual.z_index
	return carta_com_maior_z

func mao_cheia() -> bool:
	if cartas.size() < limite_cartas:
		return false
	return true
