class_name Inventario extends Node2D

var _classes : Array[Classe]
var _racas : Array[Raca]
var _capacete : Capacete
var _armadura : Armadura
var _botas : Botas
var _equipamentoMao : Array[EquipamentoMao]
var _modificadores : Array


var inventario_bg : Sprite2D 

func _setup_sprite_temp() -> void:
	var viewport_size = get_viewport_rect().size

	inventario_bg = Sprite2D.new()
	var texture = GradientTexture2D.new()
	var gradient = Gradient.new()
	gradient.colors = [Color.from_hsv(0.42, 0.46, 0.84)]  
	texture.gradient = gradient

	texture.width = viewport_size.x - 100
	texture.height = viewport_size.y - 100

	inventario_bg.texture = texture
	inventario_bg.position = viewport_size / 2


func _setup_close_btn() -> void:
	var btn := Button.new()
	btn.text = 'X'
	btn.position = Vector2(inventario_bg.get_rect().size.x - btn.size.x - 50, btn.size.y + 100)
	btn.z_index = 10
	add_child(btn)
	btn.pressed.connect(_on_close_pressed)


func _on_close_pressed() -> void:
	self.visible = false


func _ready():
	_setup_sprite_temp()
	_setup_close_btn()

	

	add_child(inventario_bg)
	# var slot = CardSlot.new()
	# slot.card_entered.connect(func(card): print("Card placed"))
	# slot.global_position = Vector2(1600, 500)
	# add_child(slot)


func _process(delta: float) -> void:
	pass

func _is_mao_cheia() -> bool:
	if _equipamentoMao.size() == 2 or _equipamentoMao[0].get_qtd_maos() == 2:
		return true
	return false

func _SairClicado() -> void:
	$"/root/Partida/Jogador Host/Inventario".visible = false
