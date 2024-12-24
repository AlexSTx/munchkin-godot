extends Node2D

# "onready" pega o Node antes da execução do _ready. Apenas para facilitar
#@onready var input = $CanvasLayer/PanelContainer/CenterContainer/VBoxContainer/TextEdit

# executado 1 vez ao ser posto em uma cena
func _ready():
	print('Cena iniciada')

# executado TODO frame. Muito cuidado pois é o pior inimigo da performance
func _process(delta: float) -> void:
	# verificar se o botão "action" (configurado no Project > Project Settings > Input Map) foi pressionado
	if Input.is_action_just_pressed("action"):
		# troca de cena
		# SceneManager é um script global adicionado em Project > Project Settings > Globals
		SceneManager.change_scene()
