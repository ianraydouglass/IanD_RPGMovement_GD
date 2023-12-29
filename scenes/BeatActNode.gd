extends Node2D

@export var beat_bottom: int = 0
@export var beat_top: int = 0
@export var act_int: int = 0

# Called when the node enters the scene tree for the first time.
func check_beat(b):
	if b >= beat_bottom and b <= beat_top:
		return act_int
	else:
		return -1
