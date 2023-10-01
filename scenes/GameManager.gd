extends Node2D

var player_object
var main_camera
var life_object
const camera_speed = 4.0
var follow_player: bool = false
var check_point_manager
var world_manager
# Called when the node enters the scene tree for the first time.
func _ready():
	player_object = $Player
	main_camera = $Camera2D
	life_object = $HUDLayer/LifeDisplay
	player_object.life_object = life_object
	check_point_manager = $CheckPointManager
	check_point_manager.game_manager = self
	world_manager = $World
	world_manager.game_manager = self
	world_manager.first_time_setup()
	follow_player = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if follow_player:
		cam_to_player(delta)
	else:
		return
	
func cam_to_player(delta):
	var p_pos = player_object.global_position
	var m_pos = main_camera.global_position
	main_camera.global_position = m_pos.lerp(p_pos, delta * camera_speed)
