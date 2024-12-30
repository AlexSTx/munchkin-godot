extends Node

class_name Jogador

var nome : String
var mao : Mao
var equipamentos : EquipamentosJogador
var inventario : Inventario
var nivel : int
var poder : int
var sexo : String
var ouro : int
var fuga : int

# Called when the node enters the scene tree for the first time.

func _init(_nome : String = "", _sexo : String = "Masculino") -> void:
	nome = _nome
	sexo = _sexo
	mao = Mao.new()
	equipamentos = EquipamentosJogador.new()
	inventario = Inventario.new()
	nivel = 0
	poder = 0
	ouro = 0
	fuga = 0


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


func set_nome(novo_nome:String) -> void:
	nome = novo_nome
