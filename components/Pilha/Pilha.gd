class_name Pilha extends Slot

@export var _cartas: Array[Carta]

func _criar_pilha_inicial() -> void:
	pass

func set_pilha() -> void:
	_criar_pilha_inicial()

func _ready() -> void:	
	if not _sprite:
		setup_sprite()

	if _texture:
		apply_texture(_texture)

func puxar_carta() -> void:
	Partida.get_mesa().get_porta().toggle_highlight(false)
	if _cartas.size() > 0:
		var carta = _cartas.pop_back()
		remove_child(carta)
		carta.visible = true
		
		if Partida.get_turno().fase_atual is FasePreparo:
			if carta is Monstro:
				var monstro_slot = Partida.get_mesa().get_monstro_slot()
				monstro_slot.add_carta_no_slot(carta)
			elif carta is Maldicao:
				carta.aplicar_todos_efeitos(Partida.get_jogadores()[0])
				#mostrar na tela efeito aplicado
				var descarte_slot = Partida.get_mesa().get_descarte_slot()
				descarte_slot.add_carta_no_slot(carta)
			else:
				Partida.get_jogadores()[0].get_mao().add_carta(carta)
		else:
			Partida.get_jogadores()[0].get_mao().add_carta(carta)
		emit_signal("carta_puxada", carta)
		disable_click_area()

func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		puxar_carta()
