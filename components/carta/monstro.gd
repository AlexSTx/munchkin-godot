class_name Monstro extends Carta

var fuga: int
var tesouro: int
var zumbi: bool
var lutar_sozinho: bool
var coisa_ruim : ListaEfeitos
var status : StatusEfetivo
var bonus_derrota: int

func _init(_nivel: int = 0, _titulo: String = "", _descricao: String = "", _fuga: int = 0, _tesouro: int = 0, _zumbi: bool = false, _lutar_sozinho: bool = false):
	super(_nivel, _titulo, _descricao)  # Chama o construtor da classe base
	fuga = _fuga
	tesouro = _tesouro
	zumbi = _zumbi
	lutar_sozinho = _lutar_sozinho
	coisa_ruim = ListaEfeitos.new()
	self.status = StatusEfetivo.new(self, _nivel, _fuga)
	
