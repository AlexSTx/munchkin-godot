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

func remover_efeito(ef : Efeito):
	self.efeitos.erase(ef)
	lista_alterada.emit()

func satisfaz_alguma_condicao(alvo : Object) -> bool:
	for ef in self.efeitos:
		if ef.restricoes.is_empty():
			return true
		for rest in ef.restricoes:
			if rest.satisfaz_restricao(alvo): return true
	
	return false

func satisfaz_todas_condicoes(alvo : Object) -> bool:
	for ef in self.efeitos:
		if ef.restricoes.is_empty():
			return true
		for rest in ef.restricoes:
			if rest.satisfaz_restricao(alvo): return false
	
	return true
