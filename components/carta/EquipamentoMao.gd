extends Item

class_name EquipamentoMao

var _qtd_maos: int
var card_in_slot = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _valor: int=0, _qtd_maos: int =0):
	_nivel = _nivel
	_titulo = _titulo
	_descricao = _descricao
	_valor = _valor
	_qtd_maos=_qtd_maos

func get_qtd_maos():
	return _qtd_maos;
