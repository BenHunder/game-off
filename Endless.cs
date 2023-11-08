using Godot;
using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

public partial class Endless : Node2D
{
	Hand _leftHand;
	Hand _rightHand;
	Hand _feet;

	WallManager _wallManager;
	PackedScene _popUp;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_wallManager = GetNode<WallManager>("WallManager");
		_popUp = (PackedScene)GD.Load("res://TextPopup.tscn");
		_leftHand = new Hand();
		_rightHand = new Hand();
		_feet = new Hand();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if(HasLost())
		{
			PopupPanel p = (PopupPanel)_popUp.Instantiate();
			CallDeferred("add_child", p);
			}
	}
	
	public override void _UnhandledInput(InputEvent @event)
	{
		if(@event is InputEventMouseButton mouseEvent)
		{
			_wallManager.CreateHold(mouseEvent.Position);
			
		}
		
		if(@event is InputEventKey keyEvent)
		{
			GD.Print("key press");
			if (keyEvent.Pressed && !keyEvent.Echo) HandleKeyPressed(keyEvent.Keycode);
			
			if (!keyEvent.Pressed && !keyEvent.Echo) HandleKeyReleased(keyEvent.Keycode);
		
			RichTextLabel t = GetNode<RichTextLabel>("DebugInfo");
			t.Text = "left: " + _leftHand + " right: " + _rightHand + " feet: " + _feet;
		}
	}

	private bool HasLost() => _wallManager.GameStarted && _leftHand.IsEmpty && _rightHand.IsEmpty && _feet.IsEmpty;
	
	private void HandleKeyPressed(Key k)
	{
		Regions limb = _wallManager.GetLimbForKey(k);
		GD.Print("pressed " + k + " for " + limb);
		if(limb == Regions.Left && !_leftHand.Contains(k)) _leftHand.Add(k);
		else if(limb == Regions.Right && !_rightHand.Contains(k)) _rightHand.Add(k);
		else if(limb == Regions.Middle && !_feet.Contains(k)) _feet.Add(k);
		_wallManager.GameStarted = true;
	}
	private void HandleKeyReleased(Key k)
	{
		Regions limb = _wallManager.GetLimbForKey(k);
		if(limb == Regions.Left && _leftHand.Contains(k)) _leftHand.Remove(k);
		else if(limb == Regions.Right && _rightHand.Contains(k)) _rightHand.Remove(k);
		else if(limb == Regions.Middle && _feet.Contains(k)) _feet.Remove(k);
	}

	public class Hand
	{
		public bool IsEmpty {get { return !_fingers.Any(); }}
		private List<Key> _fingers;
		private int _nKeys = 1;

		public Hand()
		{
			_fingers = new List<Key>();
		}
		public void Add(Key k)
		{
			GD.Print("adding; " + k);
			if(_fingers.Count() >= _nKeys) _fingers.RemoveAt(0);
			_fingers.Add(k);
		}
		public void Remove(Key k) => _fingers.Remove(k);
		public bool Contains(Key k) => _fingers.Contains(k);
		public override string ToString() => _fingers.Aggregate("", (acc, k) => acc + k.ToString());
	}
}
