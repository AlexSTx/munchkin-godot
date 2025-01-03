class_name Pilha extends Node2D

signal carta_puxada(carta: Carta)

@export var cartas: Array[Carta]
var mao: Mao

var click_area: Area2D
var sprite: Sprite2D
@export var texture: Texture2D

# Size in pixels for both sprite and collision shape
@export var pilha_size: Vector2 = Vector2(100, 150)


# Override em cada subclasse de pilha
func criar_pilha_inicial() -> void:
	pass

func set_pilha() -> void:
	mao = Partida.get_jogadores()[0].get_mao()
	criar_pilha_inicial()


func _ready() -> void:	
	if not sprite:
		setup_sprite()

	if texture:
		apply_texture(texture)

	if click_area:
		click_area.input_event.connect(_on_click_area_input_event)


func setup_sprite() -> void:
	sprite = Sprite2D.new()
	sprite.name = "Sprite2D"
	add_child(sprite)

func apply_texture(new_texture: Texture2D) -> void:
	if sprite:
		sprite.texture = new_texture
		# Calculate scale to match desired size
		var texture_size = new_texture.get_size()
		sprite.scale = Vector2(
			pilha_size.x / texture_size.x,
			pilha_size.y / texture_size.y
		)

func set_image(new_texture: Texture2D) -> void:
	texture = new_texture
	apply_texture(texture)


func set_size(new_size: Vector2) -> void:
	pilha_size = new_size
	
	# Update sprite size if texture exists
	if sprite and sprite.texture:
		apply_texture(sprite.texture)
	
	# Update collision shape size
	if click_area and click_area.get_child(0) is CollisionShape2D:
		var collision = click_area.get_child(0) as CollisionShape2D
		var shape = collision.shape as RectangleShape2D
		shape.size = new_size


func setup_click_area() -> void:
	click_area = Area2D.new()
	click_area.name = "ClickArea"
	
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = pilha_size
	collision.shape = shape
	
	add_child(click_area)
	click_area.add_child(collision)
	click_area.input_event.connect(_on_click_area_input_event)

func disable_click_area() -> void:
	remove_child(click_area)
	click_area = null

func puxar_carta() -> void:
	#Partida.get_mesa().get_porta().toggle_highlight(false)
	print("Tentando puxar carta")
	print("Número de cartas na pilha: ", cartas.size())
	if cartas.size() > 0:
		var carta = cartas.pop_back()
		remove_child(carta)
		carta.visible = true
		
		if Partida.get_turno().fase_atual is FasePreparo:
			if carta is Monstro:
				var monstro_slot = Partida.get_mesa().get_monstro_slot()
				monstro_slot.add_monstro(carta)
			elif carta is Maldicao:
				carta.aplicar_todos_efeitos(Partida.get_jogadores()[0])
				#mostrar na tela efeito aplicado
				var descarte_slot = Partida.get_mesa().get_descarte_slot()
				descarte_slot.add_descarte(carta)
			else:
				mao.add_carta(carta)
		else:
			mao.add_carta(carta)
		emit_signal("carta_puxada", carta)
		disable_click_area()


func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		puxar_carta()
