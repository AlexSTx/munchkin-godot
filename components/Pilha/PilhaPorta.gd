class_name PilhaPorta extends Pilha

func criar_pilha_inicial() -> void:
	self.cartas = FactoryCarta.criar_cartas_da_pilha("PORTA")

var _highlight: ColorRect

func setup_highlight() -> void:
	if not $Sprite2D or not $Sprite2D.texture:
		return
		
	_highlight = ColorRect.new()
	_highlight.color = Color(0, 1, 0, 0.5)
	_highlight.size = Vector2(200, 300) + Vector2(8, 8)
	_highlight.position = $Sprite2D.position - _highlight.size/2
	add_child(_highlight)
	_highlight.z_index = -1
	_highlight.show()

func toggle_highlight(enabled: bool) -> void:
	if _highlight:
		_highlight.visible = enabled
