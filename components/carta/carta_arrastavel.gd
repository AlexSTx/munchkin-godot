class_name CartaArrastavel extends Node2D

signal drag_started
signal drag_ended
signal clicked

var is_dragging := false
var drag_start_pos := Vector2.ZERO
var mouse_offset := Vector2.ZERO
var original_position := Vector2.ZERO

@export var drag_enabled := true
@export var return_to_start := false
@export var drag_minimum_distance := 5.0

@onready var click_area: Area2D = $ClickArea

@onready var sprite: Sprite2D = $Sprite2D
@export var texture: Texture2D

func _ready() -> void:
	original_position = position
	
	if not click_area:
		setup_click_area()
	
	if not sprite:
		setup_sprite()

	if texture:
		sprite.texture = texture

	click_area.input_event.connect(_on_click_area_input_event)


func setup_sprite() -> void:
	sprite = Sprite2D.new()
	sprite.name = "Sprite2D"
	add_child(sprite)


func set_image(new_texture: Texture2D) -> void:
	texture = new_texture
	if sprite:
		sprite.texture = texture

	if click_area and click_area.get_child(0) is CollisionShape2D:
		var collision = click_area.get_child(0) as CollisionShape2D
		var shape = collision.shape as RectangleShape2D
		if texture:
			shape.size = texture.get_size()


func setup_click_area() -> void:
	click_area = Area2D.new()
	click_area.name = "ClickArea"
	
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(100, 150)  
	collision.shape = shape
	
	add_child(click_area)
	click_area.add_child(collision)


func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not drag_enabled:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				drag_start_pos = get_global_mouse_position()
				mouse_offset = position - drag_start_pos
				is_dragging = true
				emit_signal("drag_started")
				z_index = 1
			else:
				is_dragging = false
				emit_signal("drag_ended")
				z_index = 0
				
				if return_to_start:
					position = original_position
				
				if (drag_start_pos - get_global_mouse_position()).length() < drag_minimum_distance:
					emit_signal("clicked")


func _process(_delta: float) -> void:
	if is_dragging:
		position = get_global_mouse_position() + mouse_offset


func enable_drag() -> void:
	drag_enabled = true


func disable_drag() -> void:
	drag_enabled = false


func set_return_to_start(should_return: bool) -> void:
	return_to_start = should_return