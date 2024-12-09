extends Node2D
class_name Carta



# cria um sinal (evento) para sinalizar quando a carta morrer
signal carta_morreu(Carta)

@onready var sprite2D: Sprite2D = $Imagem

# propriedade "privada" que não deve ser acessada por outros componentes/scripts
var _sprite: Texture2D
var nivel: int
var titulo: String
var descricao: String

func _ready():
	# muda o sprite
	sprite2D.texture = _sprite

# função "publica" para ser acessada por outros componentes/scripts
func setSprite(sprite: Texture2D):
	_sprite = sprite


func _on_timer_timeout() -> void:
	print('Carta morreu')
	# emite um sinal (evento)
	carta_morreu.emit(self)

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = ""):
	nivel = _nivel
	titulo = _titulo
	descricao = _descricao
