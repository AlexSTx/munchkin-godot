extends Node

class_name EquipamentosJogador

var _classes : Array[Classe]
var _racas : Array[Raca]
var _capacete : Capacete
var _armadura : Armadura
var _botas : Botas
var _equipamentoMao : Array[EquipamentoMao]
var _modificadores : Array

var carta_no_slot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func is_humano() -> bool:
	if _racas.size() == 0:
		return true
	return false

func is_mao_cheia() -> bool:
	if _equipamentoMao.size() == 2 or _equipamentoMao[0].get_qtd_maos() == 2:
		return true
	return false
