extends Node

class_name FactoryCarta

static var arquivo_cartas := preload("res://assets/cartas_munchkin_caminho.json")
const template : PackedScene = preload("res://components/carta/carta.tscn")

# Existe somente para debug
@export var cartas : Array[Dictionary]= []

func _ready() -> void:
	var r_cartas = criar_todas_as_cartas()
	for carta in r_cartas:
		cartas.append({
			"Carta": carta,
			"ListaEfeitos": carta.get_node("ListaEfeitos")
		})
	# criar_cartas_da_pilha("TESOURO")

static func int_if_not_empty(value, default : int = 0) -> int:
	return value as int if value is int else default

static func criar_carta(dados : Dictionary) -> Carta:
	var nova_carta : Node = template.instantiate()
	
	match dados['TIPO']:
		"CLASSE":
			nova_carta.set_script(Classe)
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
			if 'COISA_RUIM' in dados:
				(nova_carta as Monstro).coisa_ruim.efeitos = criar_lista_efeitos(dados['COISA_RUIM'], nova_carta)
		"RAÇA":
			nova_carta.set_script(Raca)
		_: 
			# Como Carta deve ser uma classe abstrata, qualquer carta que não especifique seu tipo é tratada como uma hábilidade
			print("Não foi possível detectar o tipo da carta " + dados['NOME'] +  ". Ela foi instanciada como Habilidade")
			nova_carta.set_script(Habilidade)
			
	
	var img = load("res://components/" + dados['CAMINHO'])
	
	
	nova_carta.titulo = dados['NOME']
	nova_carta.descricao = dados['TEXTO']
	nova_carta.nivel = dados["NIVEL"] if dados['NIVEL'] is int else 0
	(nova_carta.find_child("Sprite2D") as Sprite2D).texture = img
	# Lidando com efeitos

	if "EFEITOS" in dados:
		var efeitos = criar_lista_efeitos(dados['EFEITOS'], nova_carta)
		nova_carta.get_node("ListaEfeitos").efeitos = efeitos

	nova_carta.visible = false

	return nova_carta 

# Aqui esperamos um array de efeitos
static func criar_lista_efeitos(efeitos, carta : Carta) -> Array[Efeito]:
	var ret : Array[Efeito] = []

	for ef in efeitos:
		var novo_efeito : Efeito
		var restricoes : Array[Restricao] = []
		if "RESTRICOES" in ef:
			restricoes = criar_lista_restricoes(ef['RESTRICOES'])
		
		match ef['TIPO']:
			"ALT_FORCA":
				novo_efeito = EfeitoAlterarForca.new(restricoes, ef['VALOR'])
			"ALT_NIVEL":
				novo_efeito = EfeitoAlterarNivel.new(restricoes, ef['VALOR'])
			"ESCAPE":
				novo_efeito = EfeitoEscaparCombate.new(restricoes)
			"ALT_FUGA":
				novo_efeito = EfeitoAlterarChanceFuga.new(restricoes, ef['VALOR'])
			"COMPRAR_CARTA":
				novo_efeito = EfeitoComprarCarta.new(restricoes, ef['VALOR'])
			var outro:
				print("Efeito " + outro +" ainda não foi implementado.")
				continue

		if "TRIGGER" in ef:
			match ef['TRIGGER']:
				"DESCARTE":
					carta.carta_morreu.connect(novo_efeito.aplicar)
				var outro:
					print("O trigger + " + outro + " não foi implementado")

		ret.push_back(novo_efeito)

	return ret

static func criar_lista_restricoes(restricoes):
	var ret : Array[Restricao] = []

	for rest in restricoes:
		var nova_restricao : Restricao
		
		match rest['TIPO']:
			"FASE":
				nova_restricao = RestricaoFase.new(rest.get('VALOR'), rest.get('QUALQUER'))
			"CLASSE":
				var inverso = true if rest.get("INVERSO") else false
				nova_restricao = RestricaoClasse.new(rest['VALOR'], inverso)
			"RACA":
				var inverso = true if rest.get("INVERSO") else false
				nova_restricao = RestricaoRaca.new(rest['VALOR'], inverso)
			"SEXO":
				nova_restricao = RestricaoSexo.new(rest['VALOR'])
			var outra :
				print("Restrição " + outra +" ainda não foi implementado.")
				continue
				
		
		ret.push_back(nova_restricao)


	return ret

static func criar_todas_as_cartas() -> Array[Carta]:
	var ret : Array[Carta] = []
	
	for carta in arquivo_cartas.data:
		ret.push_back(criar_carta(carta))
	
	return ret

#TODO: Enum para representar as pilhas?
static func criar_cartas_da_pilha(pilha : String):
	var ret : Array[Carta] = []
	for carta in arquivo_cartas.data.filter(
		func(dado : Dictionary) : return dado['DECK'] == pilha and dado['CAMINHO'] != ""):
		ret.push_back(criar_carta(carta))
	
	return ret
