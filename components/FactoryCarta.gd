extends Node

class_name FactoryCarta

static var arquivo_cartas := preload("res://assets/cartas_munchkin.json")
const template : PackedScene = preload("res://components/carta/carta.tscn")


func _ready() -> void:
	criar_todas_as_cartas()
	criar_cartas_da_pilha("TESOURO")

static func int_if_not_empty(value, default : int = 0) -> int:
	return value as int if value is not String else default

static func criar_carta(dados : Dictionary) -> Carta:
	var nova_carta : Node = template.instantiate()
	
	match dados['TIPO']:
		"CLASSE":
			nova_carta.set_script(Classe)
			#TODO: Match para as diferentes classes quando as classes estiverem prontas
		"EQUIPAMENTO":
			nova_carta.set_script(Equipamento)
			#TODO: Criar match quando o json tiver o subtipo separado
			match dados['SUBTIPO']:
				"CAPACETE":
					nova_carta.set_script(Capacete)
				"ARMADURA":
					nova_carta.set_script(Armadura)
				"BOTA":
					nova_carta.set_script(Botas)
				"ARMA1M":
					nova_carta.set_script(EquipamentoMao)
					(nova_carta as EquipamentoMao)._qtd_maos = 1
				"ARMA2M":
					nova_carta.set_script(EquipamentoMao)
					(nova_carta as EquipamentoMao)._qtd_maos = 2

			(nova_carta as Item).valor = int_if_not_empty(dados['VALOR_MOEDA'])
		"ITEM":
			nova_carta.set_script(Item)
			match dados['SUBTIPO']:
				"POÇÃO":
					nova_carta.set_script(Pocao)
			
			(nova_carta as Item).valor = int_if_not_empty(dados['VALOR_MOEDA'])
		"MALDIÇÃO":
			#TODO: Implementar maldição
			nova_carta.set_script(Maldicao)
		"MONSTRO":
			nova_carta.set_script(Monstro)
			(nova_carta as Monstro).zumbi = dados['SUBTIPO'] == "MORTO VIVO"
			(nova_carta as Monstro).tesouro = int_if_not_empty(dados['TESOUROS'], 1)
		"RAÇA":
			nova_carta.set_script(Raca)
			#TODO: Match para as diferentes raças quando as classes estiverem prontas
			
	
	nova_carta.titulo = dados['NOME']
	nova_carta.descricao = dados['TEXTO']
	nova_carta.nivel = dados["NIVEL"] if dados['NIVEL'] is not String else 0
	
	return nova_carta 

static func criar_todas_as_cartas() -> Array[Carta]:
	var ret : Array[Carta] = []
	
	for carta in arquivo_cartas.data:
		ret.push_back(criar_carta(carta))
	
	return ret

#TODO: Enum para representar as pilhas?
static func criar_cartas_da_pilha(pilha : String):
	var ret : Array[Carta] = []
	for carta in arquivo_cartas.data.filter(func(dado : Dictionary) : return dado['DECK'] == pilha):
		ret.push_back(criar_carta(carta))
	
	return ret
