extends Jogador

class_name JogadorOponente

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"Status/Nível".text = str(_nivel)
	$"Status/Ouro".text = str(_ouro)
	$"Status/Poder".text = str(_poder)

func set_jogador_oponente() -> void:
	$"Status/Nome".text = _nome
