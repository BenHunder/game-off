using Godot;
using System;

public partial class Endless : Node2D
{
	PackedScene hold;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		hold = (PackedScene)GD.Load("res://Hold.tscn");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		
	}
	
	public override void _UnhandledInput(InputEvent @event)
	{
		if(@event is InputEventMouseButton mouseEvent)
		{
			GD.Print(hold);
			Node2D holdNode = (Node2D)hold.Instantiate();
			holdNode.Position = mouseEvent.Position;
			this.AddChild(holdNode);
		}
	}
}
