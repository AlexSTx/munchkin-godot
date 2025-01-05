class_name Carta extends CartaArrastavel

signal carta_morreu(carta: Carta)
signal hovered(carta: Carta)
signal hovered_off(carta: Carta)
signal descartada_por(jogador : Jogador)

var nivel: int
var titulo: String
var descricao: String

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _img_path: String = "res://assets/exodia.jpeg") -> void:
	nivel = _nivel
	titulo = _titulo
	descricao = _descricao


func aplicar_todos_efeitos(alvo : Object):
	$ListaEfeitos.aplicar_efeitos(alvo)

func satisfaz_todas_restricoes( alvo : Object ) -> bool:
	return $ListaEfeitos.satisfaz_todas_condicoes(alvo)

func satisfaz_alguma_restricao( alvo : Object ) -> bool:
	return $ListaEfeitos.satisfaz_alguma_condicao(alvo)

func get_efeitos() -> Array[Efeito]:
	return $ListaEfeitos.efeitos
