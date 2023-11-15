extends Node2D
class_name WallManager

enum Directions {
	NONE,
	N,
	S,
	E,
	W,
	NW,
	SW,
	NE,
	SE
}

var game_started : bool = false
var _wall : Array = []
var _hold : PackedScene
var _settings : GameSettings

var _key_layout : Array

var direction_dict = { Vector2(0,1): Directions.N, Vector2(0,-1): Directions.S, Vector2(1,0): Directions.E, Vector2(-1,0): Directions.W, Vector2(-1,1): Directions.NW, Vector2(-1,-1): Directions.SW, Vector2(1,1): Directions.NE, Vector2(1,-1): Directions.SE }

func _ready() -> void:
	_hold = preload("res://Hold.tscn")
	_settings = get_node("../GameSettings")
	_wall = []
	_key_layout = _settings.key_layout

func _process(delta: float) -> void:
	if game_started:
		for h in _wall.duplicate():
			h.position.y += 0.1
			if h.position.y > 225:
				remove_hold(h)

func get_key_coordinates(k: int) -> Vector2:
	var result : Vector2 = Vector2(-1, -1)
	for i in range(_key_layout.size()):
		for j in range(_key_layout[i].size()):
			if _key_layout[i][j] == k:
				result = Vector2(i, j)
	return result

func get_key_relation(k1, k2):
	var c1 = get_key_coordinates(k1)
	var c2 = get_key_coordinates(k2)
	var d = Vector2(c2.x - c1.x, c2.y - c1.y)
	return direction_dict[d]

func create_hold(pos: Vector2 = Vector2(randi_range(0, 400), randi_range(0, 50))) -> Node2D:
	if _wall.size() > 5:
		return null

	var hold_node : Node2D = _hold.instantiate()
	call_deferred("add_child", hold_node)
	hold_node.position = pos
	##var x : int = randi_range(0, int(_key_layout.size()) - 1)
	##var y : int = randi_range(0, int(_key_layout[x].size()) - 1)
	##Dprint("x,y:", x, ", ", y)
	##hold_node.get_node("Label").text = str(_key_layout[x][y])
	_wall.append(hold_node)

	return hold_node

func remove_hold(h: Node2D) -> void:
	_wall.erase(h)
	call_deferred("remove_child", h)
	h.queue_free()


func _on_timer_timeout():
	pass # Replace with function body.
