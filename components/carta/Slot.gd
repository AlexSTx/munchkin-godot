class_name Slot extends Node2D

var sprite: Sprite2D
var click_area: Area2D

@export var texture: Texture2D
@export var slot_size: Vector2 = Vector2(200, 300)

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
