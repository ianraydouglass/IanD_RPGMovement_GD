extends StaticBody2D

@export var check_point_code: String = "none"
@export var is_default: bool = false
var manager
var spawn_anchor

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_anchor = $SpawnAnchor
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func register_check_point():
	var region = get_parent()
	region.check_point_in(self)

func set_as_current():
	if manager != null:
		manager.code_as_current(self)
		pass
	
	pass
