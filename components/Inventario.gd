class_name Inventario extends Node

var _classes : Array[Classe]
var _racas : Array[Raca]
var _capacete : Capacete
var _armadura : Armadura
var _botas : Botas
var _equipamentoMao : Array[EquipamentoMao]
var _modificadores : Array


func _ready():
	self.visible = false


func _process(delta: float) -> void:
	pass


func _is_mao_cheia() -> bool:
	if _equipamentoMao.size() == 2 or _equipamentoMao[0].get_qtd_maos() == 2:
		return true
	return false


func _on_botao_fechar_inventario_pressed() -> void:
	self.visible = false


func _on_botao_inventario_host_pressed() -> void:
	self.visible = true
