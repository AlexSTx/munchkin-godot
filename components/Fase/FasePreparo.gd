class_name FasePreparo extends Fase

@onready var saquear: Button = $SaquearButton
@onready var buscar_encrenca: Button = $BuscarEncrenca
func _ready() -> void:
	var monstro_slot = Partida.get_mesa().get_monstro_slot()
	monstro_slot.monstro_added.connect(_iniciar_batalha)
	Partida.get_mesa().get_porta().sem_monstro.connect(_sem_monstro)
	saquear.hide()
	buscar_encrenca.hide()
func enter(previous_fase_path: String, data := {}) -> void:
	Partida.get_mesa().get_porta().setup_click_area()
	saquear.hide()
	buscar_encrenca.hide()
func exit() -> void:
	Partida.get_mesa().get_porta().disable_click_area()
	saquear.hide()
	buscar_encrenca.hide()
func _iniciar_batalha(monstro: Monstro) -> void:
	saquear.hide()
	buscar_encrenca.hide()
	finished.emit("Batalha", {"inimigo": monstro})

#Remover dps da IA do oponente estiver pronto
func _finalizar_turno_clicado() -> void:
	saquear.hide()
	buscar_encrenca.hide()
	finished.emit("Preparo", {})

func _sem_monstro() -> void:
	saquear.show()
	buscar_encrenca.show()
	
func _on_saquear_button_pressed() -> void:
	Partida.get_mesa().get_tesouro().puxar_carta()
	finished.emit("Final", {})
	saquear.hide()
	buscar_encrenca.hide()
