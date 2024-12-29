class_name Fase extends Node

var titulo: String
var jogador_atual: Jogador

signal finished(next_fase_path: String, data: Dictionary)

func enter(previous_fase_path: String, data := {}) -> void:
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func set_fase() -> void:
	pass
