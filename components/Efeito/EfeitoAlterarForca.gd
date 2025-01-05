extends Efeito

class_name EfeitoAlterarForca

@export var valor : int

func _init(p_restricoes : Array[Restricao], p_valor : int) -> void:
	super(p_restricoes)
	self.valor = p_valor

func aplicar( alvo : Object ) -> void:
	if not _pode_invocar(alvo): return
	
	var status := alvo.get("status") as StatusEfetivo
	status.alterar_nivel_efetivo(self.valor)
