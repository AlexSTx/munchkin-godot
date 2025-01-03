class_name FasePreparo extends Fase

func _ready() -> void:
	var monstro_slot = Partida.get_mesa().get_monstro_slot()
	monstro_slot.monstro_added.connect(iniciar_batalha)

func _process(delta: float) -> void:
	pass

func enter(previous_fase_path: String, data := {}) -> void:
	Partida.get_mesa().get_porta().setup_click_area()
	

func exit() -> void:
	Partida.get_mesa().get_porta().disable_click_area()

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

	#mudar pro tipo Monstro
func iniciar_batalha(monstro: Carta) -> void:
	finished.emit("Batalha", {"inimigo": monstro})


func _finalizar_turno_clicado() -> void:
	finished.emit("Preparo", {})
