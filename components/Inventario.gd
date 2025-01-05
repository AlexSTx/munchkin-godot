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

func equiparItem(carta : Carta):
	var jogador = get_parent() as Jogador

	if not carta.satisfaz_todas_restricoes(jogador):
		print(jogador.name + "não satisfaz as condições da carta")
		return
	match carta.get_script():
		EquipamentoMao:
			if self._equipamentoMao.is_empty():
				self._equipamentoMao.push_back(carta)
				print("Jogador equipou a arma " + carta.titulo)
				return OK
			else : print("Jogador já possui uma arma")
		Capacete:
			if self._capacete == null:
				self._capacete = carta
				print("Jogador equipou o capacete " + carta.titulo)
				return OK
			else : print("Jogador já possui um capacete")
		Armadura:
			if self._armadura == null:
				self._armadura = carta
				print("Jogador equipou a armadura " + carta.titulo)
				return OK
			else : print("Jogador já possui uma armadura")
		Botas:
			if self._botas == null:
				self._botas = carta
				print("Jogador equipou a bota " + carta.titulo)
				return OK
			else : print("Jogador já possui uma bota")
		Raca:
			if self._racas.is_empty():
				self._racas.push_back(carta)
				print("Jogador agora é da raça: " + carta.titulo)
				return OK
			else : print("Jogador já possui uma raça")
		Classe:
			if self._classes.is_empty():
				self._classes.push_back(carta)
				print("Jogador agora é da classe: " + carta.titulo)
				return OK
			else : print("Jogador já possui uma classe")
		Equipamento:
			self._modificadores.push_back(carta)
			print("Jogador equipou " + carta.titulo)
			return OK
		_:
			print("Carta recebida não é um equipamento válido")
