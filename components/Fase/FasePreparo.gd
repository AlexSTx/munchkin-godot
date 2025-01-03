class_name FasePreparo extends Fase

@onready var label_preparo = get_node("Label")
@onready var label_jogador_vez = get_node("Jogador_atual")

func _ready() -> void:
	var monstro_slot = Partida.get_mesa().get_monstro_slot()
	monstro_slot.monstro_added.connect(iniciar_batalha)

func _process(delta: float) -> void:
	pass

func enter(previous_fase_path: String, data := {}) -> void:
	label_preparo.visible = true
	label_jogador_vez.visible = true
	
	Partida.get_mesa().get_porta().setup_click_area()
	
	var jogador_atual = Partida.get_turno().get_jogador_atual()
	if jogador_atual == Partida.get_jogadores()[0]:
		$"Jogador_atual".text = "Sua vez!"
	else:
		$"Jogador_atual".text = "Vez de: " + Partida.get_turno().get_jogador_atual().get_nome()		
	print("entered PREPARO")

func exit() -> void:
	label_preparo.visible = false
	label_jogador_vez.visible = false
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
