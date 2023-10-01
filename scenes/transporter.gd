extends Node2D

var region_manager
var entry_point
@export var next_scene_index: int = 0
@export var next_port_index: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	entry_point = $"Boundries/Entry Point"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_region(r):
	region_manager = r
	
func transport_out():
	region_manager.world_manager.exit_to_entrance(next_scene_index, next_port_index)
	print("transporting from stairs")

func transport_coords():
	entry_point = $"Boundries/Entry Point"
	return entry_point.global_transform.origin
	pass
