class_name Turno extends Node

var fase_inicial : Fase
@onready var label_fase = get_node("Etapa")
@onready var label_jogador_vez = get_node("Jogador_atual")
@onready var fase_atual: Fase = (func () -> Fase:
	return fase_inicial if fase_inicial != null else get_child(2)
).call()

var jogador_atual: int # indice do jogador atual na lista de jogadores em Partida

func _ready() -> void:
	for fase_node: Fase in find_children("*", "Fase"):
		fase_node.finished.connect(_trocar_de_fase)
	
	set_label_etapa()
	set_label_jogador_atual()
	fase_atual.enter("")

func _trocar_de_fase(next_fase_path: String, data: Dictionary) -> void:
	if not has_node(next_fase_path):
		printerr(owner.name + ": tentou transicionar para estado " + next_fase_path + ", mas ele não existe.")
		return 
	var previous_fase_path := fase_atual.name

	fase_atual.exit()
	if(next_fase_path == "Preparo"):
		_troca_jogador_atual()
		set_label_jogador_atual()
	fase_atual = get_node(next_fase_path)
	set_label_etapa()
	fase_atual.enter(previous_fase_path, data)


func _troca_jogador_atual() -> void:
	if jogador_atual < len(Partida.get_jogadores())-1:
		jogador_atual += 1
	else:
		jogador_atual = 0


func set_label_jogador_atual() -> void:
	if get_jogador_atual() == Partida.get_jogadores()[0]:
		$"Jogador_atual".text = "Sua vez!"
	else:
		$"Jogador_atual".text = "Vez de: " + get_jogador_atual().get_nome()

func set_label_etapa() -> void:
	$"Etapa".text = fase_atual.name

func set_visibilidade_labels(estado: bool) -> void:
	if label_fase and label_jogador_vez:
		label_fase.visible = estado
		label_jogador_vez.visible = estado


func _unhandled_input(event: InputEvent) -> void:
	fase_atual.handle_input(event)


func _process(delta: float) -> void:
	fase_atual.update(delta)


func get_jogador_atual() -> Jogador:
	return Partida.get_jogadores()[jogador_atual]
