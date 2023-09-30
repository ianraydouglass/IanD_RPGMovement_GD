extends Node2D

var all_level_scenes = ["res://scenes/debug_level.tscn"]
var current_level_scene
var current_scene_index: int = 0
var game_manager
# Called when the node enters the scene tree for the first time.
func _ready():
	current_level_scene = get_child(0)
	pass

func regiser_region():
	pass

func get_region_check_points():
	var local_region = get_child(0)
	local_region.get_local_check_points()
	var local_points = local_region.local_check_points
	if local_points.size() > 0:
		for p in local_points:
			game_manager.check_point_manager.register_check_point(p)
	pass
