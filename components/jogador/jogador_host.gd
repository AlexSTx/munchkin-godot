class_name JogadorHost extends Jogador

func _ready() -> void:
	_mao = $Mao

func _process(_delta: float) -> void:
	$"Status/Nível".text = str(_nivel)
	$"Status/Ouro".text = str(_ouro)
	$"Status/Poder".text = str(_poder)


func set_jogador_host() -> void:
	$"Status/Nome".text = _nome
	add_child(_inventario)
	add_child(_mao)
