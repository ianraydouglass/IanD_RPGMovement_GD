extends Area2D

var this_enemy
var character_type = "detection_area"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", check_player)
	this_enemy = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func check_player(other):
	if this_enemy.mode_state == "patrol" || this_enemy.mode_state == "return":
		var character_object = other.get_owner()
		if !character_object.has_method("move_player"):
			return
		print("player detected")
		this_enemy.player_object = character_object
		this_enemy.on_detect_player()
