extends Node2D
const MASK_COLLISION = 1
const MASK_COLLISION_SLOT = 2
const MASK_COLLISION_PILHA = 4

signal mouse_esq_click
signal mouse_esq_solto

var mao_ref
var pilha_ref

func _ready() -> void:
	mao_ref = $"../Mao"
	pilha_ref = $"../Pilha"
func _input(event):
	#conecta com os eventos com a mão
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			emit_signal ("mouse_esq_click")
			raycast_no_cursor()
		else:
			emit_signal ("mouse_esq_solto")

func raycast_no_cursor():
	var space_state = get_world_2d().direct_space_state
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position = get_global_mouse_position()
	parametros.collide_with_areas=true
	var result = space_state.intersect_point(parametros)

	if result.size()>0:
		var result_collision_mask=result[0].collider.collision_mask
		print (result_collision_mask)
		if result_collision_mask == MASK_COLLISION:# verifica se clicou na carta
			var achou_carta = result[0].collider.get_parent()
			if achou_carta:
				mao_ref.comecar_arraste(achou_carta)
		elif result_collision_mask == MASK_COLLISION_PILHA: #verifica se clicou na pilha
			pilha_ref.puxar_carta()
	
