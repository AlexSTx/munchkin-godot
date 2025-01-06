class_name Habilidade extends Carta

var uso_unico: bool

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _uso_unico: bool=0):
	nivel = _nivel
	titulo = _titulo
	descricao = _descricao
	uso_unico = _uso_unico
