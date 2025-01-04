class_name JogadorHost extends Jogador

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"Status/Nível".text = str(_nivel)
	$"Status/Ouro".text = str(_ouro)
	$"Status/Poder".text = str(_poder)

func set_jogador_host() -> void:
	$"Status/Nome".text = _nome
	add_child(_inventario)
	add_child(_mao)

	var window_size = get_viewport().get_visible_rect().size
	var width = window_size.x
	var height = window_size.y
	print(window_size)
	_mao.set_mao(
		Vector2(width - 1050, height - 170), 
		1000,                
		320   
	)
	_inventario.visible = false
