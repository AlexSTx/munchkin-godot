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
	
	var inv = (alvo as Jogador).get_inventario()

	match self.item:
		"ARMADURA":
			var slot = inv._armadura.get_parent() as SlotArmadura
			slot.remove_carta(inv._armadura)
			inv.unequip(inv._armadura)
		"BOTAS":
			var slot = inv._botas.get_parent() as SlotBotas
			slot.remove_carta(inv._botas)
			inv.unequip(inv._botas)
		"CAPACETE":
			var slot = inv._capacete.get_parent() as SlotCapacete
			slot.remove_carta(inv._capacete)
			inv.unequip(inv._capacete)
		["ARMA1M", "ARMA2M"]:
			for i in inv._equipamentoMao:
				var slot = i.get_parent() as SlotEquipamentoMao
				slot.remove_carta(i)
				inv.unequip(i)
	
	print("Não foi possível encontrar " + self.item + " no equipamento do jogador")
