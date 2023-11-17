extends Node2D

var _pop_up : PackedScene
var time_elapsed := 0.0
var game_started := false

func _ready() -> void:
	_pop_up = preload("res://TextPopup.tscn")

func _process(delta: float) -> void:
	if game_started:
		time_elapsed += delta
	$DebugInfo.text = Utilities.format_seconds(time_elapsed, true) + " held_keys: " + $WallManager.held_keys

func lose():
	pass
	
func win():
	game_started = false
	var p : PopupPanel = _pop_up.instantiate()
	p.get_node('RichTextLabel').text = 'YOU WON IN ' + Utilities.format_seconds(time_elapsed, true)
	call_deferred("add_child", p)
