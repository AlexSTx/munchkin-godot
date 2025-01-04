extends Restricao

class_name RestricaoFase

@export var fase : String
@export var qualquer_jogador : bool

func _init(p_fase : String = "BATALHA", p_qualquer = false) -> void:
	self.fase = p_fase
	self.qualquer_jogador = p_qualquer if p_qualquer != null else false

# Aqui o alvo deve ser o jogador jogando a carta

func satisfaz_condicao( alvo: Object ) -> bool:
	if alvo is not Jogador:
		return false
	
	var fase_atual = Partida.get_turno().fase_atual
	
	return fase_atual.titulo == self.fase and (self.qualquer_jogador or fase_atual.get_jogador_atual() == alvo)
