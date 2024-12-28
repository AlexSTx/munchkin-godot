extends "res://components/Fase/Fase.gd"

class_name Preparo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func baterNaPorta() -> void:
	Partida.get_mesa().get_porta()
	
#func chamarMonstro() -> void:
	#var confusao_popup = preload("res://confusao_popup.tscn").instantiate()
	#add_child(confusao_popup)
	# 1- abre pop up listando as cartas do tipo Monstro que a mão do jogador possui
	# 2- jogador pode escolher um monstro ( ou mais?? n tenho certeza)
	# 3- botão de confirmar, que quando apertado, envia um sinal pro Turno passar a fase

func executar() -> void:
	pass
