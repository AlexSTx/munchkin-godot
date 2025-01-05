extends Node

class_name Inventario

var _classes : Array[Classe]
var _racas : Array[Raca]
var _capacete : Capacete
var _armadura : Armadura
var _botas : Botas
var _equipamentoMao : Array[EquipamentoMao]
var _modificadores : Array

var carta_no_slot = false
@onready var cena_inventario = preload("res://scenes/inventario.tscn").instantiate()

func _is_mao_cheia() -> bool:
	if _equipamentoMao.size() == 2 or _equipamentoMao[0].get_qtd_maos() == 2:
		return true
	return false

func _SairClicado() -> void:
	$"/root/Partida/Jogador Host/Inventario".visible = false

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


