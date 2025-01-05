extends Item

class_name Equipamento

var modificador: int
var efeito: Efeito


func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _valor: int=0, _modificador: int=0, _efeito: Efeito = null): #falta Efeito
	nivel = _nivel
	titulo = _titulo
	descricao = _descricao
	valor = _valor
	modificador= _modificador
	efeito = _efeito
