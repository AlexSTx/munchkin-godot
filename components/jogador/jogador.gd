extends Node

class_name Jogador

var _nome : String
var _mao : Mao
var _equipamentos : EquipamentosJogador
var _nivel : int
var _poder : int
var _sexo : String
var _ouro : int
var _fuga : int

# Called when the node enters the scene tree for the first time.

func set_jogador(nome : String = "", sexo : String = "Masculino") -> void:
	var cena_equip = preload("res://scenes/equipamento_jogador.tscn").instantiate()
	var cena_mao = preload("res://scenes/mao.tscn").instantiate()
	
	_nome = nome
	_sexo = sexo
	_mao = cena_mao
	_equipamentos = cena_equip
	_nivel = 0
	_poder = 0
	_ouro = 0
	_fuga = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_carta_morreu(carta : Carta) -> void:
	print("anao, vou tirar a carta")
	carta.queue_free()


func vender_item(_item : Item) -> int:
	return 0

func jogar_dado() -> int:
	return randi() % 6 + 1

func get_nome() -> String:
	return _nome
	
func get_sexo() -> String:
	return _sexo

func get_mao() -> Mao:
	return _mao
	
func get_equip() -> EquipamentosJogador:
	return _equipamentos

func get_nivel() -> int:
	return _nivel
	
func get_poder() -> int:
	return _poder

func get_ouro() -> int:
	return _ouro

func get_fuga() -> int:
	return _fuga
