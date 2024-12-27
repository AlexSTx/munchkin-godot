extends Node2D
class_name Carta



# cria um sinal (evento) para sinalizar quando a carta morrer
signal carta_morreu(Carta)
signal hovered
signal hovered_off

#@onready var sprite2D: Sprite2D = $Imagem

# propriedade "privada" que não deve ser acessada por outros componentes/scripts
var _sprite: Texture2D
var nivel: int
var titulo: String
var descricao: String
var pos_inicial_mao


func _ready() -> void:
	#todas as cartas devem ser filhas de Mão ou vai dar erro
	get_parent().connect_card_signals(self)

# função "publica" para ser acessada por outros componentes/scripts
func setSprite(sprite: Texture2D):
	_sprite = sprite


#func _on_timer_timeout() -> void:
#	print('Carta morreu')
#	# emite um sinal (evento)
#	carta_morreu.emit(self)

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = ""):
	nivel = _nivel
	titulo = _titulo
	descricao = _descricao
	


func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered",self)
	
func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off",self)
	
