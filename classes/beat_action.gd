extends Resource


@export var beat_int: int = 0
@export var beat_act: int = 0

func _init(beat = 0, act = 0):
	beat_int = beat
	beat_act = act
