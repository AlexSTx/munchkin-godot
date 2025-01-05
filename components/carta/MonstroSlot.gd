#class_name MonstroSlot extends Slot
#
#signal monstro_added(monstro: Monstro) #Apos Monstro estiver pronto, mudar pra monstro: Monstro
#signal monstro_removed(monstro: Monstro)
#
#var _monstro_atual: Monstro = null
#
#func has_monstro() -> bool:
	#return _monstro_atual != null
#
#func get_current_monstro() -> Monstro:
	#return _monstro_atual
#
#func add_monstro(monstro: Monstro) -> void:
	#if _monstro_atual:
		#remove_monstro()
	#_monstro_atual = monstro
	#monstro.position = Vector2.ZERO
	#add_child(monstro)
	#monstro.visible = true
	#emit_signal("monstro_added", monstro)
	#monstro.disable_drag()
	#emit_signal("card_added", monstro)
#
	## Aplica os efeitos do monstro ao jogador atual
	#monstro.aplicar_todos_efeitos( Partida.get_turno().get_jogador_atual() )
#
#func remove_monstro() -> void:
	#if _monstro_atual:
		#var monstro = _monstro_atual
		#remove_child(monstro)
		#_monstro_atual = null
		#emit_signal("monstro_removed", monstro)
