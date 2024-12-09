extends Carta

class_name Raca

var uso_unico: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _uso_unico: bool = 0):
	nivel = _nivel
	titulo = _titulo
	descricao = _descricao
	uso_unico = _uso_unico
