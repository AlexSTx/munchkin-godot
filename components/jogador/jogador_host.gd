class_name JogadorHost extends Jogador

func _ready() -> void:
	_mao = $Mao
	_inventario = $Inventario
	_inventario.inventario_opened.connect(_mao._on_hud_open)
	_inventario.inventario_closed.connect(_mao._on_hud_closed)
	

func _process(_delta: float) -> void:
	$"Status/Nível".text = str(_nivel)
	$"Status/Ouro".text = str(_ouro)
	$"Status/Poder".text = str(_poder)


func set_jogador_host() -> void:
	$"Status/Nome".text = _nome
