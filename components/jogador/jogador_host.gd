extends Jogador

class_name JogadorHost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"HSplitContainer/Nível".text = "Nível: "+ str(_nivel)
	$"Nome".text = _nome
	$"HSplitContainer/Ouro".text = "Ouro: " + str(_ouro)
	$"HSplitContainer/Poder".text = "Poder: " + str(_poder)

func set_jogador_host() -> void:
	add_child(_mao)
	add_child(_equipamentos)
