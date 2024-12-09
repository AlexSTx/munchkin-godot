extends Item

class_name Equipamento



var modificador: int
var efeito: Efeito

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _valor: int=0, _modificador: int=0): #falta Efeito
	nivel = _nivel
	titulo = _titulo
	descricao = _descricao
	valor = _valor
	modificador= _modificador
	#efeito: _efeito
