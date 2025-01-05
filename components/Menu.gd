class_name Menu extends Control

func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/inserirnome.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()
