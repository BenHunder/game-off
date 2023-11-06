using Godot;
using System;

public partial class Endless : Node2D
{
	PackedScene hold;
	string leftHand;
	string rightHand;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		//hold = (PackedScene)GD.Load("res://Hold.tscn");
		leftHand = "";
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		
	}
	
	public override void _UnhandledInput(InputEvent @event)
	{
		//GD.Print("event: " + @event);
		if(@event is InputEventMouseButton mouseEvent)
		{
			
			//Node2D holdNode = (Node2D)hold.Instantiate();
			//holdNode.Position = mouseEvent.Position;
			//this.AddChild(holdNode);
		}
		
		if(@event is InputEventKey keyEvent)
		{
			if (keyEvent.Pressed && !keyEvent.Echo)
			{
				string c = keyEvent.Keycode.ToString();
				if(!leftHand.Contains(c)) leftHand += c;
			}
			
			if (!keyEvent.Pressed && !keyEvent.Echo)
			{
				string c = keyEvent.Keycode.ToString();
				if(leftHand.Contains(c)) leftHand = leftHand.Replace(c,"");
			}
			
			RichTextLabel t = GetNode<RichTextLabel>("RichTextLabel");
			t.Text = leftHand;
		}
		
	}
}
