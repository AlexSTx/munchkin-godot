extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_confirmar_button_up() -> void:
	print("Foi pra batalha") # emitir sinal pra trocar de fase pra Batalha
	queue_free()
