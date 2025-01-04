class_name FaseFinal extends Fase

@onready var button: Button = $Button

func _ready() -> void:
	button.hide()
	pass


func enter(previous_fase_path: String, data := {}) -> void:
	button.show()
	pass


func exit() -> void: 
	pass


func _on_prox_button_up() -> void:
	button.hide()
	finished.emit("Preparo", {})


func set_fase() -> void:
	print("setou final")
	pass
