extends Area2D

var transport_manager
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", transport_other)
	transport_manager = $"../.."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func transport_other(other):
	var character_object = other.get_owner()
	if !character_object.has_method("move_player"):
		return
	transport_manager.transport_out()
