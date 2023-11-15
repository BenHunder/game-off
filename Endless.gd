extends Node2D

var _pop_up : PackedScene
var time_elapsed := 0.0
var game_started := false

func _ready() -> void:
	_pop_up = preload("res://TextPopup.tscn")

func _process(delta: float) -> void:
	var held_keys = ''
	var keys = []
	for key in Settings.get_flat_layout():
		if Input.is_key_pressed(key):
			held_keys += Utilities.get_key_char(key)
			keys.append(key)
			game_started = true
	$WallManager.try_grab(keys)
	if game_started:
		time_elapsed += delta
		if $WallManager.wall.is_empty(): win()
	$DebugInfo.text = Utilities.format_seconds(time_elapsed, true) + " held_keys: " + held_keys

func lose():
	pass
	
func win():
	game_started = false
	var p : PopupPanel = _pop_up.instantiate()
	p.get_node('RichTextLabel').text = 'YOU WON IN ' + Utilities.format_seconds(time_elapsed, true)
	call_deferred("add_child", p)
