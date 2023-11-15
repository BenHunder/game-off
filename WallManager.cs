using Godot;
using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

public partial class WallManager : Node2D
{
	public bool GameStarted;

	private List<Node2D> _wall;
	private PackedScene _hold;

	private GameSettings _settings;

	private Key[,] _keyLayout
	{
		get {return _settings.KeyLayout;}
	}

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_hold = (PackedScene)GD.Load("res://Hold.tscn");
		_settings = GetNode<GameSettings>("../GameSettings");
		_wall = new List<Node2D>();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if(GameStarted)
		{
			foreach(Node2D h in _wall.ToList())
			{
				h.Position = new Vector2(h.Position.X, h.Position.Y + 0.1f);
				if(h.Position.Y > 225) RemoveHold(h);
			}
		}
	}

	private Vector2 GetKeyCoordinates(Key k)
	{
		Vector2 result = new Vector2(-1,-1);
		for (int i = 0; i < _keyLayout.GetLength(0); i++) 
		{ 
			for (int j = 0; j < _keyLayout.GetLength(1); j++) 
			{ 
				if(_keyLayout[i,j] == k) result = new Vector2(i,j);
			}
		}
		return result;
	}

	public Regions GetLimbForKey(Key k)
	{
		Vector2 keyCoordinates = GetKeyCoordinates(k);
		//GD.Print("get limb for " + keyCoordinates);
		if(k == Key.Space) return Regions.Middle;
		else if(keyCoordinates.X == -1) return Regions.None;
		else return keyCoordinates.Y < Mathf.FloorToInt(_keyLayout.GetLength(1) / 2) ? Regions.Left : Regions.Right;
	}

	public void CreateHold() => CreateHold(new Vector2(GD.RandRange(0,400), 0));

	public Node2D CreateHold(Vector2 pos)
	{
		if(_wall.Count() > 5) return null;
		Node2D holdNode = (Node2D)_hold.Instantiate();
		CallDeferred("add_child", holdNode);
		holdNode.Position = pos;
		int x = GD.RandRange(0, _keyLayout.GetLength(0)-1);
		int y = GD.RandRange(0, _keyLayout.GetLength(1)-1);
		GD.Print("x,y:" + x + ", " + y);
		holdNode.GetNode<RichTextLabel>("Label").Text = _keyLayout[x,y].ToString();
		_wall.Add(holdNode);

		return holdNode;
	}

	public void RemoveHold(Node2D h)
	{
		_wall.Remove(h);
		CallDeferred("remove_child", h);
		h.Dispose();
	}
}
