class_name Turno extends Node

var fase_inicial : Fase
@onready var fase_atual: Fase = (func () -> Fase:
	return fase_inicial if fase_inicial != null else get_child(0)
).call()

var jogador_atual: int # indice do jogador atual na lista de jogadores em Partida

func _ready() -> void:
	print("qualquer pica aqui")
	for fase_node: Fase in find_children("*", "Fase"):
		fase_node.finished.connect(_trocar_de_fase)

	fase_atual.enter("")

func _trocar_de_fase(next_fase_path: String, data: Dictionary) -> void:
	if not has_node(next_fase_path):
		printerr(owner.name + ": tentou transicionar para estado " + next_fase_path + ", mas ele não existe.")
		return 

	var previous_fase_path := fase_atual.name
	fase_atual.exit()	
	fase_atual = get_node(next_fase_path)
	fase_atual.enter(previous_fase_path, data)


func _trocar_jogador_atual() -> void:
	if jogador_atual < len(Partida.get_jogadores())-1:
		jogador_atual += 1
	else:
		jogador_atual = 0


func _unhandled_input(event: InputEvent) -> void:
	fase_atual.handle_input(event)


func _process(delta: float) -> void:
	fase_atual.update(delta)


func get_jogador_atual() -> Jogador:
	return Partida.get_jogadores()[jogador_atual]
