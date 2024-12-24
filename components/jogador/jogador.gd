extends Node2D

class_name Jogador

var mao : Mao
var equipamentos : EquipamentosJogador
var inventario : Inventario
var nivel : int
var poder : int
var sexo : String
var ouro : int
var fuga : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		print("apretou meu chapa")
		var carta : Carta = mao.pegar_carta_nova()
		carta.global_position = Vector2(randf_range(0, 1000), randf_range(0, 780))
		mao.add_child(carta)
		#carta.connect("carta_morreu")

func _on_carta_morreu(carta : Carta) -> void:
	print("anao, vou tirar a carta")
	carta.queue_free()

func vender_item(item : Item) -> int:
	return 0

func jogar_dado() -> int:
	return randi() % 6 + 1
