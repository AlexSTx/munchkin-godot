class_name Fase extends Node

var _jogador_atual: Jogador

signal finished(next_fase_path: String, data: Dictionary)

func enter(previous_fase_path: String, data := {}) -> void:
	pass

func exit() -> void:
	pass

func set_fase() -> void:
	pass

func fase_bot() -> bool:
	return (_jogador_atual != Partida.get_jogadores()[0])

func get_jogador_atual() -> Jogador:
	return _jogador_atual

func set_jogador_atual(jogador: Jogador) -> void:
	_jogador_atual = jogador
