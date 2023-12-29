extends Node2D

@export var all_level_scenes = ["res://scenes/debug_level.tscn", "res://scenes/debut_level2.tscn"]
var current_level_scene
var current_scene_index: int = 0
var game_manager
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func regiser_region():
	pass

func get_region_check_points():
	var local_region = current_level_scene
	local_region.get_local_check_points()
	var local_points = local_region.local_check_points
	if local_points.size() > 0:
		for p in local_points:
			game_manager.check_point_manager.register_check_point(p)
	pass
func first_time_setup():
	#do what I would do in ready
	current_level_scene = get_child(0)
	get_region_check_points()
	current_level_setup()
	set_default_point()
	
func current_level_setup():
	current_level_scene.set_exit_points()
func set_default_point():
	game_manager.check_point_manager.set_fall_back()
	
	pass

func exit_to_entrance(s, p):
	change_to_scene(s)
	var point = current_level_scene.get_node(current_level_scene.exit_points[p])
	player_to_origin(point.transport_coords())
	pass

func respawn_to_checkpoint(s, o):
	change_to_scene(s)
	player_to_origin(o)
	pass
	
func blind_respawn(s):
	change_to_scene(s)
	if game_manager.check_point_manager.current_default_check_point != null:
		var o = game_manager.check_point_manager.current_default_check_point.global_transform.origin
		player_to_origin(o)
	#find proper origin

func player_to_origin(o):
	game_manager.player_object.global_transform.origin = o

func change_to_scene(s):
	var old_scene = current_level_scene
	old_scene.queue_free()
	var scene = load(all_level_scenes[s])
	var instance = scene.instantiate()
	add_child(instance)
	current_level_scene = instance
	current_scene_index = s
	get_region_check_points()
	current_level_setup()
	pass
