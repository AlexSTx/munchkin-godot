using System;
using Godot;

public partial class EquipamentosJogador : Node2D
{
    List<Classe> classes;
    Raca racas;
	Capacete capacete;
	Armadura armadura;
	Botas botas;
	List<EquipamentoMao> equipamentoMao;
	List<Carta> modificadores;
    // Called when the node enters the scene tree for the first time.
    public override void _Ready() 
	{
		classe = new List<Classe>;
		raca = new List<Raca>;
		equipamentoMao = new List<EquipamentoMao>;
		modificadores = new List<Carta>;
	}
    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta) { }

	public bool isHumano(){
		if(raca.Count == 0)
		{
			return true;
		}
		return false;
	}

//criar funcao getQtdMaos
	public bool isMaoCheia(){
		if(equipamentoMao.Count == 2 || equipamentoMao[0].getQtdMaos() == 2)
		{
			return true;
		}
		return false;
	}

}
