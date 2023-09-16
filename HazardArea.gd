extends Area2D

const hazard_damage = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", damage_other)


# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func damage_other(other):
	var player_object = other.get_owner()
	player_object.take_damage(hazard_damage)
	print("damage other called")
	pass
