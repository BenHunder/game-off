extends Node
class_name GameSettings

enum Key {
	Q, W, E, R, T, Y, U, I, O, P,
	A, S, D, F, G, H, J, K, L, SEMICOLON,
	Z, X, C, V, B, N, M, COMMA, PERIOD, SLASH
}

var _qwerty_matrix : Array = [
	[Key.Q, Key.W, Key.E, Key.R, Key.T, Key.Y, Key.U, Key.I, Key.O, Key.P],
	[Key.A, Key.S, Key.D, Key.F, Key.G, Key.H, Key.J, Key.K, Key.L, Key.SEMICOLON],
	[Key.Z, Key.X, Key.C, Key.V, Key.B, Key.N, Key.M, Key.COMMA, Key.PERIOD, Key.SLASH]
]

var key_layout : Array

func _ready() -> void:
	key_layout = _qwerty_matrix
