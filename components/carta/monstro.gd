extends Carta

class_name Monstro

var fuga: int
var tesouro: int
var zumbi: bool
var lutar_sozinho: bool
#var coisa_ruim: Callable


func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _fuga: int = 0, _tesouro: int = 0, _zumbi: bool = false, _lutar_sozinho: bool = false):
	super(_nivel, _titulo, _descricao)  # Chama o construtor da classe base
	fuga = _fuga
	tesouro = _tesouro
	zumbi = _zumbi
	lutar_sozinho = _lutar_sozinho
#	coisa_ruim = _coisa_ruim




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
