extends Resource

# Essa classe serve como alvo para os efeitos
# Armazena os status alterados por eles

class_name StatusEfetivo

@export var nivel_efetivo : int
var efeitos_ativos : Array[Efeito]

func _init(p_nivel : int = 1, p_efeitos_ativos : Array[Efeito] = []) -> void:
	self.nivel_efetivo = p_nivel if p_nivel >= 1 else 1
	self.efeitos_ativos = p_efeitos_ativos

func alterar_nivel_efetivo(valor : int):
	self.nivel_efetivo += valor
	if self.nivel_efetivo < 1:
		self.nivel_efetivo = 1

func adicionar_efeito_ativo(ef : Efeito):
	if ef not in self.efeitos_ativos:
		self.efeitos_ativos.push_back(ef)
