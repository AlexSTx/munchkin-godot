extends Item

class_name EquipamentoMao

var _qtd_maos: int
var carta_no_slot = false

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _valor: int=0, _qtd_maos: int =0):
	_nivel = _nivel
	_titulo = _titulo
	_descricao = _descricao
	_valor = _valor
	_qtd_maos=_qtd_maos

func get_qtd_maos():
	return _qtd_maos;
