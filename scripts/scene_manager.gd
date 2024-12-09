extends Node

@onready var background: PanelContainer = $PanelContainer

# "preload" permite carregar qualquer arquivo dentro da Godot, estou carregando
# a cena (.tscn) diretamente para poder trocar a cena.
var scena_1 = preload('res://scenes/game.tscn')
var scena_2 = preload('res://scenes/game2.tscn')
var scene_atual = 1

func _ready():
	background.modulate = Color(0, 0, 0, 0)

func change_scene():
	# troca de cena em loop (1 -> 2 -> 1 -> 2 -> 1 -> ...)
	if scene_atual == 1:
		_change_to(scena_2)
		scene_atual = 2
	else:
		_change_to(scena_1)
		scene_atual = 1

func _change_to(scena: PackedScene):
	# tween permitem interpolar propriedades, útil para animações simples
	var tween = get_tree().create_tween()
	# interpola a coloração do "background" para simular um fade-in
	tween.tween_property(background, 'modulate', Color(1, 1, 1, 1), 1)
	# aguarda a animação ser finalizada (ficar tudo preto)
	await tween.finished
	
	# troca de cena
	get_tree().change_scene_to_packed(scena)
	
	tween = get_tree().create_tween()
	# interpola a coloração do "background" para simular um fade-out
	tween.tween_property(background, 'modulate', Color(0, 0, 0, 0), 1)
