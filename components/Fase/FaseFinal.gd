class_name FaseFinal extends Fase

@onready var prox = get_node("prox")
@onready var label = get_node("Label")

signal trocar_jogador

func _ready() -> void:
	connect("trocar_jogador", Callable(Partida.get_turno(), "_trocar_jogador_atual"))
	prox.visible = false
	label.visible = false


func enter(previous_fase_path: String, data := {}) -> void:
	prox.visible = true
	label.visible = true
	print("entered FINAL")


func exit() -> void: 
	prox.visible = false
	label.visible = false


func _on_prox_button_up() -> void:
	finished.emit("Preparo", {})


func set_fase() -> void:
	print("setou final")
	pass
