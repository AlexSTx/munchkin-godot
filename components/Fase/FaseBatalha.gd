class_name FaseBatalha extends Fase

@onready var mensagem_label: Label = $MensagemLabel
@onready var botoes_container: GridContainer = $BotoesContainer
@onready var enfrentar_button: Button = $BotoesContainer/EnfrentarButton
@onready var fugir_button: Button = $BotoesContainer/FugirButton



func _ready() -> void:
	# Esconder elementos inicialmente
	botoes_container.hide()
	mensagem_label.hide()

func enter(previous_fase_path: String, data := {}) -> void:

	botoes_container.show()
	mensagem_label.show()
	mensagem_label.text = "O que você deseja fazer?"

func exit() -> void:
	botoes_container.hide()
	mensagem_label.hide()
	mensagem_label.text = ""

func _on_enfrentar_button_pressed() -> void:
	# Implementar lógica de combate aqui
	pass

func _on_fugir_button_pressed() -> void:
	# Gerar número aleatório entre 1 e 6
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var dado = rng.randi_range(1, 6)
	
	# Atualizar mensagem
	if dado >=5 :
		mensagem_label.text = "Você rolou %d! Conseguiu fugir!" % dado
		# Desabilitar botões durante a animação
		enfrentar_button.disabled = true
		fugir_button.disabled = true
		# Esperar 2 segundos e mudar de fase
		await get_tree().create_timer(2.0).timeout
		finished.emit("Preparo", {})
	else:
		mensagem_label.text = "Você rolou %d! Não conseguiu fugir..." % dado

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass
