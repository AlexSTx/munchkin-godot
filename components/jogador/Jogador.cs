using Godot;
using System;
using EquipamentosJogador;

public class Jogador: Node2D
{
	private Mao mao;
	private EquipamentosJogador equipamentos;
	private Inventario inventario;
	private int nivel;
	private int poder;
	private string sexo;
	private int ouro;
	private int fuga;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		mao = new Mao();
		equipamentos = new EquipamentosJogador();
		inventario = new Inventario();
		nivel = 1;
		poder = 0;
		ouro = 0;
		fuga = 0;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if(Input.is_action_just_pressed("action"))
		{
			Console.WriteLine('apretou meu chapa');
			# chama um método do component "mao", que é adicionado como propriedade deste componente
			Carta carta = mao.pegarCartaNova();
			# seta uma posição aleatória para a carta
			carta.global_position = Vector2(randf_range(0, 1000), randf_range(0, 780));
			# adiciona a carta à "mão"
			mao.add_child(carta);
			
			# conecta-se ao sinal (Evento) da carta para ser notificado quando a carta morrer.
			# quando a carta morrer, a funcão _on_carta_morreu será executada
			carta.carta_morreu.connect(self._on_carta_morreu);
		}
	}

# é executada quando a carta morrer por conta do connect na linha 18
	public void _on_carta_morreu(Carta carta)
	{
		Console.WriteLine('anao, vou tirar a carta');
		# deleta a carta
		carta.queue_free();
	}

	private int venderItem(Item item)
	{
		//
	}

	private int jogarDado()
	{
		Random rnd = new Random();
		return rnd.Next(1,7);
	}
}
