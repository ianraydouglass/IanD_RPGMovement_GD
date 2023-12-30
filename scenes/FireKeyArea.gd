extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", register_other)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func destroy_this():
	queue_free()

func register_other(other):
	var character_object = other.get_owner()
	if !character_object.has_method("move_player"):
		return
	character_object.game_manager.collect.set_fire_key_status("player")
	self.queue_free()
