extends Node2D

var ice_key_area
# Called when the node enters the scene tree for the first time.
func _ready():
	ice_key_area = $IceKeyArea
	check_key_status()
	pass # Replace with function body.


func check_key_status():
	var collection = get_tree().get_root().get_node("GameManager/HUDLayer/Collect")
	if collection.is_ice_key_loose() == true:
		return
	else:
		ice_key_area.destroy_this()
