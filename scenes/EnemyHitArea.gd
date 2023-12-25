extends Area2D

const enemy_damage = 1

var is_player_within: bool = false
var player_object
var position_anchor
var this_enemy
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", register_other)
	connect("area_exited", clear_other)
	position_anchor = $"../PositionAnchor"
	this_enemy = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
#we want the player to take damage as soon as their invulnerability ends
func _process(delta):
	if is_player_within and player_object != null:
		#we want to snap the knockback to a direction, so we add true
		player_object.take_damage(enemy_damage, position_anchor.global_position, true)
		if this_enemy.mode_state != "gloat":
			this_enemy.on_hit_player()
	#damage the player if they are still within the area
	
	
func register_other(other):
	var character_object = other.get_owner()
	if !character_object.has_method("move_player"):
		return
	player_object = character_object
	is_player_within = true

func clear_other(other):
	var character_object = other.get_owner()
	if !character_object.has_method("move_player"):
		return
	is_player_within = false
	player_object = null
