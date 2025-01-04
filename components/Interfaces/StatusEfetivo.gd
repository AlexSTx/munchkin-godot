extends Resource

# Essa classe serve como alvo para os efeitos
# Armazena os status alterados por eles

class_name StatusEfetivo

@export var nivel_efetivo : int
# Podemos usar tanto para determinar a chance de fuga do jogador como um modificador de fuga do monstro
@export var fuga_efetiva : int
var efeitos_ativos : ListaEfeitos

func _init(
	p_dono : Carta,
	p_nivel : int = 1,
	p_fuga : int = 0) -> void:
		self.dono = p_dono
		self.nivel_efetivo = p_nivel if p_nivel >= 1 else 1
		self.fuga_efetiva = p_fuga
		self.efeitos_ativos = ListaEfeitos.new()

func alterar_nivel_efetivo(valor : int):
	self.nivel_efetivo += valor
	if self.nivel_efetivo < 1:
		self.nivel_efetivo = 1
		
func recalcular():
	self.nivel_efetivo = self.dono.nivel
	self.fuga_efetiva = self.dono.fuga
	self.efeitos_ativos.aplicar_efeitos(self.dono)


func alterar_fuga_efetiva(valor : int):
	self.fuga_efetiva += valor

func adicionar_efeito_ativo(ef : Efeito):
	if ef not in self.efeitos_ativos.efeitos:
		self.efeitos_ativos.adicionar_efeito(ef)
