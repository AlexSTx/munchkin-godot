extends Node2D
class_name Carta

signal carta_morreu(carta: Carta)
signal hovered(carta: Carta)
signal hovered_off(carta: Carta)

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

var nivel: int
var titulo: String
var descricao: String

var pos_inicial_mao: Vector2

# função "publica" para ser acessada por outros componentes/scripts
func setSprite(sprite: Texture2D):
	_sprite = sprite


func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "") -> void:
	nivel = _nivel
	titulo = _titulo
	descricao = _descricao

func _ready() -> void:
	var parent = get_parent()
	if parent is Pilha:
		pass
	elif parent is Mao:
		parent.connect_card_signals(self)

func setup_card(texture: Texture2D, _nivel: int, _titulo: String, _descricao: String) -> void:
	sprite.texture = texture
	self.nivel = _nivel
	self.titulo = _titulo
	self.descricao = _descricao
	
	var shape = RectangleShape2D.new()
	shape.size = texture.get_size()
	collision_shape.shape = shape

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)
	
func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)
