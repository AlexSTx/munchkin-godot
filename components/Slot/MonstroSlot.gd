class_name MonstroSlot extends Slot

signal monstro_added(monstro: Monstro)
signal monstro_removed(monstro: Monstro)

var _monstro: Monstro = null

func add_carta_no_slot(carta: Carta) -> void:
	_monstro = carta as Monstro
	print("print do monstro", _monstro.nivel)
	if _carta_no_slot:
		remove_carta_do_slot()
	_carta_no_slot = _monstro
	_monstro.position = Vector2.ZERO
	add_child(_monstro)
	_monstro.visible = true
	emit_signal("monstro_added", _monstro)
	_monstro.disable_drag()
	emit_signal("card_added", _monstro)

	# Aplica os efeitos do monstro ao jogador atual
	_monstro.aplicar_todos_efeitos(Partida.get_turno().get_jogador_atual() )

func add_monstro(monstro: Monstro) -> void:
	if _monstro:
		remove_carta_do_slot()
	_monstro = monstro
	monstro.position = Vector2.ZERO
	add_child(monstro)
	monstro.visible = true
	emit_signal("monstro_added", monstro)
	monstro.disable_drag()
	emit_signal("card_added", monstro)

	# Aplica os efeitos do monstro ao jogador atual
	monstro.aplicar_todos_efeitos( Partida.get_turno().get_jogador_atual() )

func remove_carta_do_slot() -> void:
	if _carta_no_slot:
		var monstro = _carta_no_slot
		remove_child(monstro)
		_carta_no_slot = null
		emit_signal("monstro_removed", monstro)
		
func get_current_monstro() -> Monstro:
	return _monstro
