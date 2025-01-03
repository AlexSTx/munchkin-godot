class_name FaseBatalha extends Fase

func _ready() -> void:
	pass

func enter(previous_fase_path: String, data := {}) -> void:
	pass


func exit() -> void: 
	pass

func FimBatalha() -> void:
	finished.emit("Final", {})
	

func set_fase() -> void:
	print("setou batalha")
	pass
