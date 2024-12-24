extends Node2D
class_name Mao

# Permite adicionar um componente (cena) qualquer para ser usado pelo script através
# do inspetor da Godot (painel do lado direito ao selecionar Node com este script)
@export var carta: PackedScene
@export var sprites: Array[Texture2D]
var card_being_dragged
var screen_size
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
		card_being_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x),
		clamp(mouse_pos.y,0,screen_size.y))
		
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var carta = raycast_check_for_card()
			if carta:
				card_being_dragged = carta
			else:
				card_being_dragged = null

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas=true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)
	if result.size()>0:
		print(result[0].collider)
	return null
