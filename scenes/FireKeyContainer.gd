extends Node2D


var fire_key_area
# Called when the node enters the scene tree for the first time.
func _ready():
	fire_key_area = $FireKeyArea
	check_key_status()
	pass # Replace with function body.


func check_key_status():
	var collection = get_tree().get_root().get_node("GameManager/HUDLayer/Collect")
	if collection.is_fire_key_loose() == true:
		return
	else:
		fire_key_area.destroy_this()
