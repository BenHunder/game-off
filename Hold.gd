extends Node2D
@onready var _animated_sprite = $CharacterBody2D/AnimatedSprite2D

var hold_types = ["small_N_", "small_S_", "small_E_", "small_W_", "small_NW_", "small_SW_", "small_SE_", "small_NE_", ]
var directions = []
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

# Called when the node enters the scene tree for the first time.
func _ready():
	var random_hold = hold_types[randi() % hold_types.size()];
	for d in Directions.values():
		if random_hold.contains("_" + str(d) + "_"):
			directions.append(d);
	_animated_sprite.play(hold_types[randi() % hold_types.size()])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
