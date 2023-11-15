extends Node
	
func format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	if not use_milliseconds:
		return '%02d:%02d' % [minutes, seconds]
	var milliseconds := fmod(time, 1) * 100
	return '%02d:%02d:%02d' % [minutes, seconds, milliseconds]
	
func get_key_char(key):
	if key == KEY_SPACE:
		return '_'
	if key == KEY_SEMICOLON:
		return ';'
	if key == KEY_COMMA:
		return ','
	if key == KEY_PERIOD:
		return '.'
	if key == KEY_SLASH:
		return '/'
	return OS.get_keycode_string(key)
