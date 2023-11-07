using Godot;
using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

public partial class Endless : Node2D
{
	PackedScene hold;
	Hand leftHand;
	Hand rightHand;
	
	List<Key> leftCharacters = new List<Key>()
	{
		Key.Q,
		Key.W,
		Key.E,
		Key.R,
		Key.T,
		Key.A,
		Key.S,
		Key.D,
		Key.F,
		Key.G,
		Key.Z,
		Key.X,
		Key.C,
		Key.V,
		Key.B	
	};
	List<Key> rightCharacters = new List<Key>()
	{
		Key.Y,
		Key.U,
		Key.I,
		Key.O,
		Key.P,
		Key.H,
		Key.J,
		Key.K,
		Key.L,
		Key.Semicolon,
		Key.N,
		Key.M,
		Key.Comma,
		Key.Period,
		Key.Slash	
	};
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		hold = (PackedScene)GD.Load("res://Hold.tscn");
		leftHand = new Hand();
		rightHand = new Hand();
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
			
			Node2D holdNode = (Node2D)hold.Instantiate();
			holdNode.Position = mouseEvent.Position;
			this.AddChild(holdNode);
		}
		
		if(@event is InputEventKey keyEvent)
		{
			if (keyEvent.Pressed && !keyEvent.Echo) HandleKeyPressed(keyEvent.Keycode);
			
			if (!keyEvent.Pressed && !keyEvent.Echo) HandleKeyReleased(keyEvent.Keycode);
			
			RichTextLabel t = GetNode<RichTextLabel>("RichTextLabel");
			t.Text = "left: " + leftHand + " right: " + rightHand;
		}
	}
	
	private void HandleKeyPressed(Key k)
	{
		if(leftCharacters.Contains(k) && !leftHand.Fingers.Contains(k)) leftHand.Fingers.Add(k);
		else if(rightCharacters.Contains(k) && !rightHand.Fingers.Contains(k)) rightHand.Fingers.Add(k);
	}
	private void HandleKeyReleased(Key k)
	{
		if(leftCharacters.Contains(k) && leftHand.Fingers.Contains(k)) leftHand.Fingers.Remove(k);
		else if(rightCharacters.Contains(k) && rightHand.Fingers.Contains(k)) rightHand.Fingers.Remove(k);
	}

	public class Hand
	{
		public List<Key> Fingers;

		public Hand()
		{
			Fingers = new List<Key>();
		}

		public override string ToString() => Fingers.Aggregate("", (acc, k) => acc + k.ToString());
	}
}
