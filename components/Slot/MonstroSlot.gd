class_name MonstroSlot extends Slot

signal monstro_added(monstro: Monstro)
signal monstro_removed(monstro: Monstro)

func _init() -> void:
	disable_container()


func add_carta(carta: Carta) -> void:
	connect_carta(carta)
	if not can_receive_cards or not carta is Monstro:
		return
	var monstro = carta as Monstro
	if _carta:
		remove_carta(carta)
	_carta = monstro
	monstro.position = Vector2.ZERO
	add_child(monstro)
	monstro.visible = true
	emit_signal("monstro_added", monstro)
	monstro.disable_drag()
	emit_signal("card_added", monstro)

	# Aplica os efeitos do monstro ao jogador atual
	monstro.aplicar_todos_efeitos(Partida.get_turno().get_jogador_atual() )

	
func remove_carta(carta: Carta) -> void:
	disconnect_carta(carta)
	if _carta:
		var monstro = _carta
		remove_child(monstro)
		_carta = null
		emit_signal("monstro_removed", monstro)
