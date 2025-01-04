class_name CartaArrastavel extends Node2D

signal inicia_arrasto
signal fim_do_arrasto
signal carta_clicada

var pos_inicial_arrasto = Vector2.ZERO
var mouse_offset = Vector2.ZERO 
var posicao_original = Vector2.ZERO
var arrastando = false
var hover = true
var animacao_hover: Tween

@export var drag_enabled = true
@export var cancela_arrasto = false

var click_area: Area2D 
var sprite: Sprite2D 

@export var textura: Texture2D

func _ready() -> void:
	posicao_original = position
	setup_click_area()
	setup_sprite()

	if textura:
		sprite.textura = textura

	click_area.input_event.connect(_on_click_area_input_event)
	click_area.mouse_entered.connect(_mouse_na_carta)
	click_area.mouse_exited.connect(_mouse_saiu_da_carta)


func setup_sprite() -> void:
	sprite = Sprite2D.new()
	sprite.name = "Sprite2D"
	add_child(sprite)


func set_image(nova_textura: Texture2D) -> void:
	textura = nova_textura
	if sprite:
		sprite.textura = textura

	if click_area and click_area.get_child(0) is CollisionShape2D:
		var colisao = click_area.get_child(0) as CollisionShape2D
		var area_colisao = colisao.shape as RectangleShape2D
		if textura:
			area_colisao.size = textura.get_size()


func setup_click_area() -> void:
	click_area = Area2D.new()
	click_area.name = "ClickArea"
	
	var colisao = CollisionShape2D.new()
	var area_colisao = RectangleShape2D.new()
	area_colisao.size = Vector2(200, 300)  
	colisao.shape = area_colisao
	
	add_child(click_area)
	click_area.add_child(colisao)


func _mouse_na_carta() -> void:
	if arrastando or not hover:
		return
		
	if animacao_hover:
		animacao_hover.kill()
	
	animacao_hover = create_tween()
	animacao_hover.tween_property(self, "scale", Vector2.ONE * 1.2, 0.1  )

func _mouse_saiu_da_carta() -> void:
	if arrastando:
		return
	
	if animacao_hover:
		animacao_hover.kill()
	
	animacao_hover = create_tween()
	animacao_hover.tween_property(self, "scale", Vector2.ONE, 0.1  )

func _on_click_area_input_event(evento: InputEvent) -> void:
	if not drag_enabled:
		return
		
	if evento is InputEventMouseButton and evento.button_index == MOUSE_BUTTON_LEFT :
		if evento.pressed:
			pos_inicial_arrasto = get_global_mouse_position()
			mouse_offset = position - pos_inicial_arrasto
			arrastando = true
			emit_signal("inicia_arrasto")
			z_index = 1

			if animacao_hover:
				animacao_hover.kill()
			scale = Vector2.ONE
		else:
			var was_click = (pos_inicial_arrasto - get_global_mouse_position()).length() < 5.0
			_finaliza_arrastar()
			if was_click:
				emit_signal("carta_clicada")


func _process(_delta: float) -> void:
	if arrastando and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_finaliza_arrastar()
	
	if arrastando:
		position = get_global_mouse_position() + mouse_offset

func _finaliza_arrastar() -> void:
	arrastando = false
	emit_signal("fim_do_arrasto")
	z_index = 0
	
	if cancela_arrasto:
		position = posicao_original


func enable_drag() -> void:
	drag_enabled = true


func disable_drag() -> void:
	drag_enabled = false


func habilita_hover_anim() -> void:
	hover = true


func desabilita_hover_anim() -> void:
	hover = false


func set_cancela_arrasto(cancelar: bool) -> void:
	cancela_arrasto = cancelar
