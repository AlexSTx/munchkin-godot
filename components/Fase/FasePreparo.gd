class_name FasePreparo extends Fase

@onready var saquear: Button = $SaquearButton
@onready var buscar_encrenca: Button = $BuscarEncrenca
@onready var mensagem_label: Label = $MensagemLabel

var primeiro_turno:=true
func _ready() -> void:
	var monstro_slot = Partida.get_mesa().get_monstro_slot()
	monstro_slot.monstro_added.connect(_iniciar_batalha)
	Partida.get_mesa().get_porta().sem_monstro.connect(_sem_monstro)
	saquear.hide()
	buscar_encrenca.hide()
	if primeiro_turno == true:
		for i in range (3):
			Partida.get_mesa().get_porta().puxar_carta()
			Partida.get_mesa().get_tesouro().puxar_carta()
		primeiro_turno=false
func enter(previous_fase_path: String, data := {}) -> void:
	Partida.get_mesa().get_porta().enable_click_area()
	saquear.hide()
	buscar_encrenca.hide()
	Partida.get_mesa().get_monstro_slot().can_receive_cards=false

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
	if primeiro_turno == false:
		saquear.show()
		buscar_encrenca.show()
		Partida.get_mesa().get_monstro_slot().can_receive_cards=true
	
func _on_saquear_button_pressed() -> void:
	Partida.get_mesa().get_tesouro().puxar_carta()
	finished.emit("Final", {})
	saquear.hide()
	buscar_encrenca.hide()


func _on_buscar_encrenca_pressed() -> void:
	mensagem_label.text = "Arraste uma carta Monstro para o Slot"
	await get_tree().create_timer(2.0).timeout
	mensagem_label.text = ""
