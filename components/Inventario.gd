class_name Inventario extends Node2D

var _classes : Array[Classe]
var _racas : Array[Raca]
var _capacete : Capacete
var _armadura : Armadura
var _botas : Botas
var _equipamentoMao : Array[EquipamentoMao]
var _modificadores : Array

signal inventario_opened
signal inventario_closed

func _ready():
	self.visible = false
	change_slots_collision_layer()


func _process(delta: float) -> void:
	pass


func _is_mao_cheia() -> bool:
	if _equipamentoMao.size() == 2 or _equipamentoMao[0].get_qtd_maos() == 2:
		return true
	return false


func _on_botao_fechar_inventario_pressed() -> void:
	inventario_closed.emit()
	self.visible = false


func _on_botao_inventario_host_pressed() -> void:
	inventario_opened.emit()
	self.visible = true


func change_slots_collision_layer() -> void:
	for c in get_children():
		if c is CardContainer:
			var slot = c as CardContainer
			slot.area.collision_layer = 2
			slot.area.collision_mask = 2