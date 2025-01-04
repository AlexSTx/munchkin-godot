class_name MonstroSlot extends Slot

signal monstro_added(monstro: Monstro)
signal monstro_removed(monstro: Monstro)

func add_carta_no_slot(carta: Carta) -> void:
	var monstro = carta as Monstro
	if _carta_no_slot:
		remove_carta_do_slot()
	_carta_no_slot = monstro
	monstro.position = Vector2.ZERO
	add_child(monstro)
	monstro.visible = true
	emit_signal("monstro_added", monstro)
	monstro.disable_drag()
	emit_signal("card_added", monstro)

	# Aplica os efeitos do monstro ao jogador atual
	monstro.aplicar_todos_efeitos(Partida.get_turno().get_jogador_atual() )

func remove_carta_do_slot() -> void:
	if _carta_no_slot:
		var monstro = _carta_no_slot
		remove_child(monstro)
		_carta_no_slot = null
		emit_signal("monstro_removed", monstro)
