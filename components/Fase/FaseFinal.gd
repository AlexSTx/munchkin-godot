class_name FaseFinal extends Fase

func _ready() -> void:
	pass


func enter(previous_fase_path: String, data := {}) -> void:
	pass


func exit() -> void: 
	pass


func _on_prox_button_up() -> void:
	finished.emit("Preparo", {})


func set_fase() -> void:
	print("setou final")
	pass
