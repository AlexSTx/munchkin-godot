class_name FasePreparo extends Fase

@onready var button: Button = $Button

func _ready() -> void:
	var monstro_slot = Partida.get_mesa().get_monstro_slot()
	monstro_slot.monstro_added.connect(_iniciar_batalha)

func enter(previous_fase_path: String, data := {}) -> void:
	Partida.get_mesa().get_porta().setup_click_area()
	button.show()
func exit() -> void:
	Partida.get_mesa().get_porta().disable_click_area()
	button.hide()
func _iniciar_batalha(monstro: Monstro) -> void:
	finished.emit("Batalha", {"inimigo": monstro})


func _finalizar_turno_clicado() -> void:
	finished.emit("Preparo", {})
