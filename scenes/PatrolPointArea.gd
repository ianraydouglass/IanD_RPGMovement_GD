extends Area2D


var patrol_point

# Called when the node enters the scene tree for the first time.
func _ready():
	patrol_point = $".."
	connect("area_entered", register_enemy)
	connect("area_exited", clear_other)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func register_enemy(other):
	var character_object = other.get_owner()
	if character_object.character_type != "enemy":
		return
	patrol_point.notify_patrol_area()
	pass
	
#I don't even think we need a clear other on this one
func clear_other(other):
	var character_object = other.get_owner()
	if character_object.character_type != "enemy":
		return
	pass
