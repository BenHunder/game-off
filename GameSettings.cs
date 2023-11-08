using Godot;
using System;

public partial class GameSettings : Node
{
	private static readonly Key[,] _qwertyMatrix = { 
		{ Key.Q, Key.W, Key.E, Key.R, Key.T, Key.Y, Key.U, Key.I, Key.O, Key.P}, 
		{ Key.A, Key.S, Key.D, Key.F, Key.G, Key.H, Key.J, Key.K, Key.L, Key.Semicolon},
		{ Key.Z, Key.X, Key.C, Key.V, Key.B, Key.N, Key.M, Key.Comma, Key.Period, Key.Slash}
	};
	
	public Key[,] KeyLayout;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		KeyLayout = _qwertyMatrix;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
