extends Control

var player_name;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_line_edit_text_submitted(new_text: String) -> void:
	print(new_text)
	


func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
