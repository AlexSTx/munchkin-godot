extends Control

var nome_jogador: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")


func _on_enter_pressed() -> void:
	Sistema.cadastra(nome_jogador)
	get_tree().change_scene_to_file("res://scenes/Partida.tscn")
	Partida.set_Partida(Sistema._jogadores_cadastrados)


func _on_line_edit_text_changed(new_text: String) -> void:
	nome_jogador = new_text
