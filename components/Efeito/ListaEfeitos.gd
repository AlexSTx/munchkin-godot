extends Node

class_name ListaEfeitos

signal lista_alterada

@export var efeitos : Array[Efeito] = []

func _ready() -> void:
	pass # Replace with function body.

func aplicar_efeitos(alvo : Object) -> void:
	for ef in efeitos:
		ef.aplicar(alvo)

func adicionar_restricao(rest : Restricao) -> void:
	for ef in efeitos:
		ef.restricoes.push_back(rest)

func adicionar_efeito(efeito : Efeito) -> void:
	self.efeitos.push_back(efeito)
	lista_alterada.emit()

func remover_efeito(index : int):
	self.efeitos.remove_at(index)
	lista_alterada.emit()
