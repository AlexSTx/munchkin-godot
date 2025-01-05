class_name FaseFinal extends Fase

@onready var button: Button = $Button
@onready var mensagem_label: Label = $MensagemLabel
func _ready() -> void:
	button.hide()
	pass


func enter(previous_fase_path: String, data := {}) -> void:
	button.show()
	pass


func exit() -> void: 
	pass


func _on_prox_button_up() -> void:
	if Partida.get_turno().get_jogador_atual().get_mao().get_cartas_na_mao() > Partida.get_turno().get_jogador_atual().get_mao().get_limite():
		mensagem_label.text = "Você ultrapassou o limite de %d cartas,\n descarte cartas para terminar seu turno" %  Partida.get_turno().get_jogador_atual().get_mao().get_limite()
		await get_tree().create_timer(1.0).timeout
		mensagem_label.text = ""
	else:
		button.hide()
		finished.emit("Preparo", {})


func set_fase() -> void:
	print("setou final")
	pass
