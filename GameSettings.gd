extends Node
class_name GameSettings

var qwerty_matrix : Array = [
	[KEY_Q, KEY_W, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_U, KEY_I, KEY_O, KEY_P,],
	[KEY_A, KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K, KEY_L, KEY_SEMICOLON,],
	[KEY_Z, KEY_X, KEY_C, KEY_V, KEY_B, KEY_N, KEY_M, KEY_COMMA, KEY_PERIOD, KEY_SLASH,]
]

var v1 = [KEY_F,KEY_J,KEY_F,KEY_J,KEY_F,KEY_J,KEY_F,KEY_J,KEY_F,KEY_J,KEY_F,KEY_J,]
var v2 = [KEY_F,KEY_J,KEY_F,KEY_D,KEY_F,KEY_J,KEY_F,KEY_J,KEY_K,KEY_J,KEY_K,KEY_J,]

var key_layout : Array

func _ready() -> void:
	key_layout = qwerty_matrix

func get_flat_layout():
	var flattened_array = []

	for row in key_layout:
		for element in row:
			flattened_array.append(element)

	return flattened_array
