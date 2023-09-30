extends Area2D

var check_point

# Called when the node enters the scene tree for the first time.
func _ready():
	check_point = $".."
	connect("area_entered", set_as_current)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_as_current(other):
	var character_object = other.get_owner()
	if character_object.character_type != "player":
		return
	check_point.set_as_current()
	pass
