class_name Fase extends Node

var jogador_atual: Jogador

signal finished(next_fase_path: String, data: Dictionary)

func enter(previous_fase_path: String, data := {}) -> void:
	pass

func exit() -> void:
	pass

func set_fase() -> void:
	pass
