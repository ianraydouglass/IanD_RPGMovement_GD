extends Area2D

var player_object
var is_player_within
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", register_other)
	connect("area_exited", clear_other)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func register_other(other):
	var character_object = other.get_owner()
	if !character_object.has_method("move_player"):
		return
	player_object = character_object
	is_player_within = true
	player_object.register_ice(self)

func clear_other(other):
	var character_object = other.get_owner()
	if !character_object.has_method("move_player"):
		return
	player_object.deregister_ice(self)
	is_player_within = false
	player_object = null
