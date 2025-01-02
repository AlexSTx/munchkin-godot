extends Jogador

class_name JogadorHost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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

	_mao.set_hand_area(
        Vector2(width - 1050, height - Carta.CARD_HEIGHT/2.0 - 20), 
        1000,                
        20 + Carta.CARD_HEIGHT    
    )
	_inventario.visible = false


func _InventarioClicado() -> void:
	_inventario.visible = true
	print_tree_pretty()
