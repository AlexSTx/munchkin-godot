class_name Jogador extends Node

var _nome : String
var _mao : Mao
var _inventario : Inventario
var _nivel : int
var _poder : int
var _sexo : String
var _ouro : int
var _fuga : int
var status : StatusEfetivo

signal mudou_nivel(novo_nivel : int)

func set_jogador(nome : String = "", sexo : String = "Masculino") -> void:	
	_nome = nome
	_sexo = sexo
	_nivel = 1
	_poder = 1
	_ouro = 0
	_fuga = 0
	status = StatusEfetivo.new(self, _nivel, _fuga)
	mudou_nivel.connect(status.alterar_nivel_base)
	status.alterou_poder.connect(self._on_alterou_poder)

func _on_carta_morreu(carta : Carta) -> void:
	print("anao, vou tirar a carta")
	carta.queue_free()

func vender_item(_item : Item) -> int:
	return 0


func jogar_dado() -> int:
	return randi() % 6 + 1


func get_nome() -> String:
	return _nome
	
  
func get_sexo() -> String:
	return _sexo


func get_mao() -> Mao:
	return _mao
	
  
func get_inventario() -> Inventario:
	return _inventario


func get_nivel() -> int:
	return _nivel
	
  
func get_poder() -> int:
	return _poder


func get_ouro() -> int:
	return _ouro


func get_fuga() -> int:
	return _fuga

func _on_alterou_poder():
	self._poder = self.status.nivel_efetivo

func set_nivel(valor : int) -> void:
	self._nivel = valor if valor > 0 else 1
	mudou_nivel.emit(self._nivel)
  
	self._poder = self.status.nivel_efetivo
	
func add_nivel(valor : int) -> void:
	self._nivel += valor
	self._poder+=valor
	if self._nivel < 1:
		self._nivel = 1
	
	mudou_nivel.emit(self._nivel)
