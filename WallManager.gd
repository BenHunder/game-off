extends Node2D
class_name WallManager

var wall : Array = []
var _hold : PackedScene
var _parent
const WIDTH = 400
const HEIGHT = 225
const TRIGGER_HEIGHT = 170
var held_keys = ''

var regrip_list = [] #represents keys that need to be released before they become valid again

var current_level

func _ready() -> void:
	_hold = preload("res://Hold.tscn")
	_parent = get_parent()
	wall = []
	current_level = [] + Settings.v2
	var n = 10 #ie how many steps shoud be rendered at a time
	for i in range(0,n):
		create_hold()
	position = Vector2(position.x, TRIGGER_HEIGHT - wall.front().position.y)

func _process(delta: float) -> void:
	held_keys = ''
	var keys = []
	for key in Settings.get_flat_layout():
		if Input.is_physical_key_pressed(key):
			held_keys += Utilities.get_key_char(key)
			keys.append(key)
			_parent.game_started = true
	update_regrip_list(keys)
	for key in regrip_list:
		if regrip_list.has(key):
			keys.erase(key)
	try_grab(keys)	
	
	if _parent.game_started:
		if wall.is_empty(): _parent.win()

func try_grab(keys):
	if wall.is_empty(): return
	for target_key in wall.front().keys:
		if not keys.has(target_key): return
	advance()

func advance():
	if !wall.is_empty(): remove_hold(wall.front())
	if !wall.is_empty(): position = Vector2(position.x, TRIGGER_HEIGHT - wall.front().position.y)
	if !current_level.is_empty(): create_hold()
	var rand_key_array = [KEY_J,KEY_F,KEY_K,KEY_D]
	current_level.append(rand_key_array[randi_range(0,3)])
	
func get_key_coordinates(k: int) -> Vector2:
	var result : Vector2 = Vector2(-1, -1)
	for i in range(Settings.key_layout.size()):
		for j in range(Settings.key_layout[i].size()):
			if Settings.key_layout[i][j] == k:
				result = Vector2(j,i)
	return result

func create_hold() -> Node2D:
	if current_level.is_empty(): return
	var hold_node = _hold.instantiate()
	call_deferred('add_child', hold_node)
	var flat_layout = Settings.get_flat_layout()
	##var new_key = flat_layout[randi_range(0,flat_layout.size()-1)]
	var new_key = current_level.pop_front()
	hold_node.keys.append(new_key)
	var kc = get_key_coordinates(new_key)
#	hold_node.position = Vector2(kc.x * WIDTH/Settings.key_layout[0].size(), (8-level_index+1) * 20)
	var y_top = 0
	if wall.back(): y_top = wall.back().position.y
	hold_node.position = Vector2(kc.x * WIDTH/Settings.key_layout[0].size(), y_top - 25)
	hold_node.get_node('Label').text = (hold_node as Hold)._to_string()
	wall.append(hold_node)

	return hold_node

func update_regrip_list(keys):
	for key in regrip_list:
		if !keys.has(key):
			regrip_list.erase(key)

func remove_hold(h: Node2D) -> void:
	regrip_list += h.keys
	wall.erase(h)
	call_deferred('remove_child', h)
	h.queue_free()
