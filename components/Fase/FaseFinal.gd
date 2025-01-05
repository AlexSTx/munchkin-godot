class_name FaseFinal extends Fase

@onready var button: Button = $Button
@onready var mensagem_label: Label = $MensagemLabel
func _ready() -> void:
	button.hide()
	pass


func enter(previous_fase_path: String, data := {}) -> void:
	if fase_bot():
		button.hide()
		await get_tree().create_timer(2.0).timeout
		finished.emit("Preparo", {})
	else:
		button.show()
		pass


func exit() -> void: 
	pass

func _finaliza_turno() -> void:
	if Partida.get_turno().get_jogador_atual().get_mao().get_cartas_na_mao() > Partida.get_turno().get_jogador_atual().get_mao().get_limite():
		mensagem_label.text = "Você ultrapassou o limite de %d cartas,\n descarte cartas para terminar seu turno" %  Partida.get_turno().get_jogador_atual().get_mao().get_limite()
		await get_tree().create_timer(1.0).timeout
		mensagem_label.text = ""
	else:
		button.hide()
		finished.emit("Preparo", {})
