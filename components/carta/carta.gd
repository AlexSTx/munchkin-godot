class_name Carta extends CartaArrastavel

signal carta_morreu(carta: Carta)
signal hovered(carta: Carta)
signal hovered_off(carta: Carta)

var nivel: int
var titulo: String
var descricao: String

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _img_path: String = "res://assets/exodia.jpeg") -> void:
	nivel = _nivel
	titulo = _titulo
	descricao = _descricao


func aplicar_todos_efeitos(alvo : Object):
	$ListaEfeitos.aplicar_efeitos(alvo)
