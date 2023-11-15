extends Node2D
class_name WallManager

var game_started : bool = false
var wall : Array = []
var _hold : PackedScene
const WIDTH = 400
const HEIGHT = 225
var level_index = 0

func _ready() -> void:
	_hold = preload("res://Hold.tscn")
	wall = []
	var n = 8
	for i in range(0,n):
		create_hold()
		level_index += 1

func _process(delta: float) -> void:
	pass	

func try_grab(held_keys):
	if wall.is_empty(): return
	for target_key in wall[0].keys:
		if not held_keys.has(target_key): return
	advance()

func advance():
	if not wall.is_empty():
		remove_hold(wall[0])
	for hold in wall:
		hold.position = Vector2(hold.position.x, hold.position.y + 20)
	if level_index < Settings.current_level.size()-1:
		create_hold()
		level_index += 1

func get_key_coordinates(k: int) -> Vector2:
	var result : Vector2 = Vector2(-1, -1)
	for i in range(Settings.key_layout.size()):
		for j in range(Settings.key_layout[i].size()):
			if Settings.key_layout[i][j] == k:
				result = Vector2(i, j)
	return result

func create_hold() -> Node2D:
	if wall.size() > 5:
		return null

	var hold_node = _hold.instantiate()
	call_deferred('add_child', hold_node)
	var flat_layout = Settings.get_flat_layout()
	##var new_key = flat_layout[randi_range(0,flat_layout.size()-1)]
	var new_key = Settings.current_level[level_index]
	hold_node.keys.append(new_key)
	var kc = get_key_coordinates(new_key)
	##hold_node.position = Vector2(kc.y * 10, kc.x * WIDTH/settings.key_layout[0].size())
	hold_node.position = Vector2((level_index%2 * 50) + 150, (8-level_index+1) * 20)
	hold_node.get_node('Label').text = (hold_node as Hold)._to_string()
	wall.append(hold_node)

	return hold_node

func remove_hold(h: Node2D) -> void:
	wall.erase(h)
	call_deferred('remove_child', h)
	h.queue_free()


func _on_timer_timeout():
	pass # Replace with function body.
