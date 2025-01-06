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
	set_slots_signals()


func _is_mao_cheia() -> bool:
	if _equipamentoMao.size() == 2 or (_equipamentoMao.size() == 1 and _equipamentoMao[0].get_qtd_maos() == 2):
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

		
func set_slots_signals() -> void:
	for c in get_children():
		if c is Slot:
			var slot = c as Slot
			slot.put_card.connect(equip)
			slot.took_card.connect(unequip)
			

func equip(carta: Carta) -> void:
	if carta is Armadura:
		_armadura = carta

	if carta is Botas:
		_botas = carta

	if carta is Capacete:
		_capacete = carta

	if carta is Classe:
		_classes.push_back(carta)

	if carta is Raca:
		_racas.push_back(carta)

	if carta is EquipamentoMao:
		_equipamentoMao.push_back(carta)


func unequip(carta: Carta) -> void:
	if carta is Armadura:
		_armadura = null

	if carta is Botas:
		_botas = null

	if carta is Capacete:
		_capacete = null

	if carta is Classe:
		var i = _classes.find(carta)
		if i != -1:
			_classes.remove_at(i)

	if carta is Raca:
		var i = _racas.find(carta)
		if i != -1:
			_racas.remove_at(i)

	if carta is EquipamentoMao:
		var i = _equipamentoMao.find(carta)
		if i != -1:
			_equipamentoMao.remove_at(i)

func ser_saqueado_inventario() -> Array[Carta]:
	var cartas_saqueadas: Array[Carta] = []
	
	if _classes.size()>0:
		cartas_saqueadas.append_array(_classes)
		for i in _classes:
			var slot = i.get_parent() as SlotClasse
			slot.remove_carta(i)
			unequip(i)
	if _racas.size()>0:
		cartas_saqueadas.append_array(_racas)
		for i in _racas:
			var slot = i.get_parent() as SlotRaca
			slot.remove_carta(i)
			unequip(i)
	if _capacete != null:
		cartas_saqueadas.append(_capacete)
		var slot = _capacete.get_parent() as SlotCapacete
		slot.remove_carta(_capacete)
		unequip(_capacete)
	if _armadura != null:
		cartas_saqueadas.append(_armadura)
		var slot = _armadura.get_parent() as SlotArmadura
		slot.remove_carta(_armadura)
		unequip(_armadura)
	if _botas != null:
		cartas_saqueadas.append(_botas)
		var slot = _botas.get_parent() as SlotBotas
		slot.remove_carta(_botas)
		unequip(_botas)
	if _equipamentoMao.size()>0:
		cartas_saqueadas.append_array(_equipamentoMao)
		for i in _equipamentoMao:
			var slot = i.get_parent() as SlotEquipamentoMao
			slot.remove_carta(i)
			unequip(i)

	return cartas_saqueadas
