extends Jogador

class_name JogadorHost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"HSplitContainer/Nível".text = "Nível: "+ str(nivel)
	$"Nome".text = nome
	$"HSplitContainer/Ouro".text = "Ouro: " + str(ouro)
	$"HSplitContainer/Poder".text = "Poder: " + str(poder)
