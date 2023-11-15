extends Node2D


class Player:
	var left_hand : Hand
	var right_hand : Hand

	func held_limbs() -> int:
		var result = 0
		if left_hand.key:
			result += 1
		if right_hand.key:
			result += 1
		return result

	func set_hand(h: Hand, k: int, n: Node2D) -> void:
		h.key = k
		h.hold = n
		h.position = n.position
		
	func try_grab(k: int, n: Node2D):
			return

	func let_go_of(k: int) -> void:
		if left_hand.key == k:
			left_hand.clear()
		if right_hand.key == k:
			right_hand.clear()

	func is_holding(k: int) -> bool:
		return left_hand.key == k or right_hand.key == k

var _player := Player.new()

var _wallManager : WallManager
var _popUp : PackedScene

func _ready() -> void:
	_wallManager = get_node("WallManager")
	_popUp = preload("res://TextPopup.tscn")

func _process(delta: float) -> void:
	if has_lost():
		var p : PopupPanel = _popUp.instantiate()
		call_deferred("add_child", p)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event : InputEventMouseButton = event
		_wallManager.create_hold(mouse_event.position)

	if event is InputEventKey:
		var key_event : InputEventKey = event
		print("key press")
		if key_event.pressed and not key_event.echo:
			print(key_event)
			if key_event.keycode == KEY_F: print("yup ")
			handle_key_pressed(key_event.keycode)

		if not key_event.pressed and not key_event.echo:
			handle_key_released(key_event.keycode)

		var t : RichTextLabel = get_node("DebugInfo")
		t.text = "player: " + str(_player)

func has_lost() -> bool:
	return _wallManager.game_started and _player.is_empty()

func handle_key_pressed(k: int) -> void:
	for i in _player._held.keys():
		for j in _wallManager._wall:
			var relation = _wallManager.get_key_relation(i, j)
			print(i, ", ", j, " relation is ", relation)
			if j.directions.contains(relation) and i.position.distance_to(j.position):
				print("match")
				_player.try_grab(k, null)
	if _player.held_limbs() > 1:
		_wallManager.game_started = true

func handle_key_released(k: int) -> void:
	_player.remove(k)
