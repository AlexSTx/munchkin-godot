extends Node2D
class_name Jogador

@onready var mao: Mao = $Mao

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		print('apertou meu chapa')
		# chama um método do component "mao", que é adicionado como propriedade deste componente
		#var carta = mao.pegarCartaNova()
		# seta uma posição aleatória para a carta
		#carta.global_position = Vector2(randf_range(0, 1000), randf_range(0, 780))
		# adiciona a carta à "mão"
		#mao.add_child(carta)
		
		# conecta-se ao sinal (Evento) da carta para ser notificado quando a carta morrer.
		# quando a carta morrer, a funcão _on_carta_morreu será executada
		#carta.carta_morreu.connect(self._on_carta_morreu)
# é executada quando a carta morrer por conta do connect na linha 18
#func _on_carta_morreu(carta: Carta):
#	print('anao, vou tirar a carta')
#	# deleta a carta
#	carta.queue_free()
	
