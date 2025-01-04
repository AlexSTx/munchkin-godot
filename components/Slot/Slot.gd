class_name Slot extends Node2D

var _carta_no_slot: Carta = null
var _sprite: Sprite2D
var _click_area: Area2D
var _size: Vector2

@export var _texture: Texture2D

func _ready() -> void:
	setup_sprite()
	setup_click_area()

func setup_sprite() -> void:
	_sprite = Sprite2D.new()
	_sprite.name = "Sprite2D"
	add_child(_sprite)
	
	if _texture:
		apply_texture(_texture)

func apply_texture(new_texture: Texture2D) -> void:
	if _sprite:
		_sprite.texture = new_texture
		# Calcula a escala para corresponder ao tamanho desejado
		var texture_size = new_texture.get_size()
		_sprite.scale = Vector2(
			_size.x / texture_size.x,
			_size.y / texture_size.y
		)

func set_image(new_texture: Texture2D) -> void:
	_texture = new_texture
	apply_texture(_texture)

func setup_click_area() -> void:
	_click_area = Area2D.new()
	_click_area.name = "ClickArea"
	
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	print(_size)
	print(collision.global_position)
	shape.size = _size
	collision.shape = shape
	
	add_child(_click_area)
	_click_area.add_child(collision)
	_click_area.input_event.connect(_on_click_area_input_event)

func disable_click_area() -> void:
	remove_child(_click_area)
	_click_area = null

func set_size(new_size: Vector2) -> void:
	_size = new_size

func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	pass

func has_carta_no_slot() -> bool:
	return _carta_no_slot != null

func get_carta_no_slot() -> Carta:
	return _carta_no_slot

func add_carta_no_slot(carta: Carta) -> void:
	pass

func remove_carta_do_slot() -> void:
	pass
