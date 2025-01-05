class_name FasePreparo extends Fase

func _ready() -> void:
	var monstro_slot = Partida.get_mesa().get_monstro_slot()
	monstro_slot.monstro_added.connect(_iniciar_batalha)

func enter(previous_fase_path: String, data := {}) -> void:
	Partida.get_mesa().get_porta().enable_click_area()
	
func exit() -> void:
	Partida.get_mesa().get_porta().disable_click_area()

func _iniciar_batalha(monstro: Monstro) -> void:
	finished.emit("Batalha", {"inimigo": monstro})


func _finalizar_turno_clicado() -> void:
	finished.emit("Preparo", {})
