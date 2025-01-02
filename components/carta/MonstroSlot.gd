class_name MonstroSlot extends Node2D

signal monstro_add(monstro: Carta) #Apos Monstro estiver pronto, mudar pra monstro: Monstro
signal monstro_removed(monstro: Monstro)

var _monstro_atual: Carta = null
var sprite: Sprite2D
var click_area: Area2D

@export var texture: Texture2D
@export var slot_size: Vector2 = Vector2(CartaArrastavel.CARD_WIDTH, CartaArrastavel.CARD_HEIGHT)

func _ready() -> void:
	setup_sprite()
	setup_click_area()

func setup_sprite() -> void:
	sprite = Sprite2D.new()
	sprite.name = "Sprite2D"
	add_child(sprite)
	
	if texture:
		apply_texture(texture)

func apply_texture(new_texture: Texture2D) -> void:
	if sprite:
		sprite.texture = new_texture
		# Calcula a escala para corresponder ao tamanho desejado
		var texture_size = new_texture.get_size()
		sprite.scale = Vector2(
			slot_size.x / texture_size.x,
			slot_size.y / texture_size.y
		)

func set_image(new_texture: Texture2D) -> void:
	texture = new_texture
	apply_texture(texture)

func setup_click_area() -> void:
	click_area = Area2D.new()
	click_area.name = "ClickArea"
	
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = slot_size
	collision.shape = shape
	
	add_child(click_area)
	click_area.add_child(collision)

func has_monstro() -> bool:
	return _monstro_atual != null

func get_current_monstro() -> Monstro:
	return _monstro_atual

func add_monstro(monstro: Carta) -> void:
	if _monstro_atual:
		remove_monstro()
	
	_monstro_atual = monstro
	monstro.position = Vector2.ZERO
	add_child(monstro)
	monstro.visible = true
	emit_signal("monstro_added", monstro)
	monstro.disable_drag()
	emit_signal("card_added", monstro)
func remove_monstro() -> void:
	if _monstro_atual:
		var monstro = _monstro_atual
		remove_child(monstro)
		_monstro_atual = null
		emit_signal("monstro_removed", monstro)
