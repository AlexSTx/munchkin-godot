extends Efeito

class_name EfeitoRemoverItem

@export var item : String

func _init(p_restricoes : Array[Restricao] = [], p_item : String = "") -> void:
	super(p_restricoes)
	self.item = p_item

func aplicar( alvo : Object ) -> void:
	if not _pode_invocar(alvo): return
	
	if alvo is not Jogador: 
		return
	
	for prop in (alvo as Jogador).equipamentos.get_property_list():
		if prop.get("class_name") == item:
			prop["class_name"] = null
			return
			
	
	print("Não foi possível encontrar " + self.item + " no equipamento do jogador")
