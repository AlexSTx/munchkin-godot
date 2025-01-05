class_name MonstroSlot extends Slot

signal monstro_added(monstro: Monstro)
signal monstro_removed(monstro: Monstro)


func accepts_card(carta: Carta) -> bool:
	return carta is Monstro and can_receive_cards


func add_carta(carta: Carta) -> void:	
	connect_carta(carta)

	var monstro = carta as Monstro
	if _carta:
		remove_carta(carta)
	_carta = monstro
  
	print("print do monstro", monstro.nivel)

	monstro.position = Vector2.ZERO
	add_child(monstro)

	emit_signal("monstro_added", monstro)
	monstro.disable_drag()

	# Aplica os efeitos do monstro ao jogador atual
	monstro.aplicar_todos_efeitos(Partida.get_turno().get_jogador_atual())

	
func remove_carta(carta: Carta) -> void:
	disconnect_carta(carta)
	if _carta:
		var monstro = _carta
		remove_child(monstro)
		_carta = null
		emit_signal("monstro_removed", monstro)
		
	
func get_current_monstro() -> Monstro:
	return _carta as Monstro
