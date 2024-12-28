extends "res://components/Fase/Fase.gd"

class_name Preparo

signal FimDoPreparo

@onready var timer = get_node("Timer")
@onready var opcoes = get_node("HBoxContainer")
@onready var confusaopopup = get_node("confusao_popup")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("FimDoPreparo", Callable(Partida.get_turno(), "passar_fase"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func TimerTimeout() -> void:
	var opcoes = get_node("HBoxContainer")
	opcoes.visible = true
	timer.stop()

func set_fase() -> void:
	timer.start()
	opcoes.visible = false
	confusaopopup.visible = false

func ChamarMonstro() -> void:
	confusaopopup.visible = true
	# 1- abre pop up listando as cartas do tipo Monstro que a mão do jogador possui
	# 2- jogador pode escolher um monstro ( ou mais?? n tenho certeza)
	# 3- botão de confirmar, que quando apertado, envia um sinal pro Turno passar a fase (sinal ainda a ser implementado)


func BaterNaPorta() -> void:
	pass #implementar bater na porta aqui


func ConfirmarConfusao() -> void:
	emit_signal("FimDoPreparo") # emitir sinal pra trocar de fase pra Batalha
