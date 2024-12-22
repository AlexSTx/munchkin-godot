using System;
using Godot;
using Carta;

public partial class Inventario : Node2D

    private List<Carta> cartas;

{
    // Called when the node enters the scene tree for the first time.
    public override void _Ready() 
    {
        cartas = new List<Carta>;
    }
    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta) { }

    public void adicionarCarta(Carta carta){
        cartas = carta;
    }
    public void ativarCarta(Carta carta){
        foreach(efeito in carta.efeitos)
        {
            efeito.aplicar();
        }
    }
    public void darCarta(Jogador jogador, Carta carta){}
}
