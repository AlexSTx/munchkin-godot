extends Node2D
class_name Pilha

const MASK_COLLISION = 1
const MASK_COLLISION_SLOT = 2

signal mouse_esq_click
signal mouse_esq_solto
signal carta_puxada(carta: Carta)

var MASK_COLLISION_PILHA: int
@export var carta_scene: PackedScene = preload("res://components/carta/carta.tscn")
@export var sprites: Array[Texture2D]
@export var cartas_na_pilha: Array[Carta] = []

var mao_ref: Mao

func _ready() -> void:
	pass

# Override em cada subclasse de pilha
func criar_pilha_inicial() -> void:
	pass

func set_pilha() -> void:
	mao_ref = Partida.get_jogadores()[0].get_mao()
	connect("mouse_esq_solto", Callable(mao_ref, "mouse_esq_solto"))
	criar_pilha_inicial()

func puxar_carta() -> void:
	if cartas_na_pilha.size() > 0:
		var carta = cartas_na_pilha.pop_back()
		remove_child(carta)
		mao_ref.add_child(carta)
		mao_ref.add_carta_para_mao(carta)
		carta.visible = true
		emit_signal("carta_puxada", carta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and !Partida.get_jogadores()[0].get_mao().mao_cheia():
			emit_signal("mouse_esq_click")
			raycast_no_cursor()
		else:
			emit_signal("mouse_esq_solto")

func raycast_no_cursor() -> void:
	mao_ref = Partida.get_jogadores()[0].get_mao()
	var space_state = get_world_2d().direct_space_state
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position = get_global_mouse_position()
	parametros.collide_with_areas = true
	var result = space_state.intersect_point(parametros)

	if result.size() > 0:
		var result_collision_mask = result[0].collider.collision_mask
		if result_collision_mask == MASK_COLLISION:
			var achou_carta = result[0].collider.get_parent()
			if achou_carta:
				mao_ref.comecar_arraste(achou_carta)
		elif result_collision_mask == MASK_COLLISION_PILHA:
			print("vc clicou em puxar carta")
			puxar_carta()
