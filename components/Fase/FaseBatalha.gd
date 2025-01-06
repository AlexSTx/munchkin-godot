class_name FaseBatalha extends Fase

@onready var mensagem_label: Label = $MensagemLabel
@onready var botoes_container: GridContainer = $BotoesContainer
@onready var enfrentar_button: Button = $BotoesContainer/EnfrentarButton
@onready var fugir_button: Button = $BotoesContainer/FugirButton


var monstro_atual : Monstro

func _ready() -> void:
	# Esconder elementos inicialmente
	botoes_container.hide()
	mensagem_label.hide()

func enter(previous_fase_path: String, data := {}) -> void:
	if fase_bot():
		exit()
		finished.emit("Final", {})
	monstro_atual = Partida.get_mesa().get_monstro_slot().get_current_monstro()
	print(monstro_atual)
	botoes_container.show()
	mensagem_label.show()
	mensagem_label.text = "O que você deseja fazer?"

func exit() -> void:
	botoes_container.hide()
	mensagem_label.hide()
	mensagem_label.text = ""

func _enfrentar_monstro() -> void:
	if Partida.get_turno().get_jogador_atual().get_poder()> monstro_atual.nivel:
		mensagem_label.text = "Você derrotou o monstro!"
		await get_tree().create_timer(1.0).timeout
		for i in range(monstro_atual.tesouro):
			Partida.get_mesa().get_tesouro().puxar_carta()
		Partida.get_turno().get_jogador_atual().add_nivel(monstro_atual.bonus_derrota)
		Partida.get_mesa().get_monstro_slot().remove_carta(monstro_atual)
		Partida.get_mesa().get_descarte_slot().add_carta(monstro_atual)
		finished.emit("Final", {})
	else:
		mensagem_label.text = "Você perdeu para o Monstro"
		await get_tree().create_timer(2.0).timeout
		mensagem_label.text = ""
		coisa_ruim()
		pass

func _fuga() -> void:
	# Gerar número aleatório entre 1 e 6
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var dado = rng.randi_range(1, 6)
	
	# Atualizar mensagem
	if dado >= 5 :
		mensagem_label.text = "Você rolou %d! Conseguiu fugir!" % dado
		# Desabilitar botões durante a animação
		enfrentar_button.disabled = true
		fugir_button.disabled = true
		# Esperar 2 segundos e mudar de fase
		await get_tree().create_timer(2.0).timeout
		enfrentar_button.disabled = false
		fugir_button.disabled = false
		Partida.get_mesa().get_monstro_slot().remove_carta(monstro_atual)
		Partida.get_mesa().get_descarte_slot().add_carta(monstro_atual)
		finished.emit("Preparo", {})
	else:
		mensagem_label.text = "Você rolou %d! Não conseguiu fugir do Monstro" % dado
		await get_tree().create_timer(2.0).timeout
		mensagem_label.text = ""
		coisa_ruim()
		finished.emit("Preparo", {})

func coisa_ruim():
	monstro_atual.coisa_ruim.aplicar_efeitos(Partida.get_turno().get_jogador_atual())
	Partida.get_mesa().get_monstro_slot().remove_carta(monstro_atual)
	Partida.get_mesa().get_descarte_slot().add_carta(monstro_atual)
	finished.emit("Final", {})
