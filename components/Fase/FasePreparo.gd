class_name FasePreparo extends Fase

@onready var opcoes = get_node("HBoxContainer")
@onready var confusaopopup = get_node("confusao_popup")


func _ready() -> void:
	opcoes.visible = false
	confusaopopup.visible = false

func _process(delta: float) -> void:
	pass

func enter(previous_fase_path: String, data := {}) -> void:
	opcoes.visible = true
	print("entered PREPARO")

	
func exit() -> void:
	opcoes.visible = false
	confusaopopup.visible = false


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func _on_chamar_monstro_pressed() -> void:
	confusaopopup.visible = true
	print("chama papai")
	# 1- abre pop up listando as cartas do tipo Monstro que a mão do jogador possui
	# 2- jogador pode escolher um monstro ( ou mais?? n tenho certeza)
	# 3- botão de confirmar, que quando apertado, envia um sinal pro Turno passar a fase (sinal ainda a ser implementado)

	
func BaterNaPorta() -> void:
	pass #implementar bater na porta aqui


func ConfirmarConfusao() -> void:
	print("tava em " + name)
	finished.emit("Batalha", {})
