class_name FaseBatalha extends Fase

@onready var container = get_node("VSplitContainer")

func _ready() -> void:
	container.visible = false

func enter(previous_fase_path: String, data := {}) -> void:
	container.visible = true
	print("entered BATALHA")


func exit() -> void: 
	container.visible = false

func FimBatalha() -> void:
	finished.emit("Final", {})
	

func set_fase() -> void:
	print("setou batalha")
	pass
