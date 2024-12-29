extends Node

class_name FactoryCarta

static var arquivo_cartas := preload("res://assets/cartas_munchkin.json")
const template : PackedScene = preload("res://components/carta/carta.tscn")


func _ready() -> void:
	criar_todas_as_cartas()

static func criar_carta(dados : Dictionary) -> Carta:
	var nova_carta : Node = template.instantiate()
	
	match dados['TIPO']:
		"CLASSE":
			nova_carta.set_script(Classe)
			assert(nova_carta is Classe)
			#TODO: Match para as diferentes classes quando as classes estiverem prontas
		"EQUIPAMENTO":
			nova_carta.set_script(Equipamento)
			#TODO: Criar match quando o json tiver o subtipo separado
		"ITEM":
			nova_carta.set_script(Item)
			match dados['SUBTIPO']:
				"POÇÃO":
					nova_carta.set_script(Pocao)
			
			(nova_carta as Item).valor = dados['VALOR_MOEDA'] if dados['VALOR_MOEDA'] is not String else 0
		"MALDIÇÃO":
			nova_carta.set_script(Maldicao)
		"MONSTRO":
			nova_carta.set_script(Monstro)
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
