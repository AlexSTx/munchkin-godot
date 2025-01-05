extends Jogador

class_name JogadorOponente

func _ready() -> void:
	_inventario = Inventario.new()
	_mao = Mao.new()


func _process(_delta: float) -> void:
	$"Status/Nível".text = str(_nivel)
	$"Status/Ouro".text = str(_ouro)
	$"Status/Poder".text = str(_poder)


func set_jogador_oponente() -> void:
	$"Status/Nome".text = _nome
