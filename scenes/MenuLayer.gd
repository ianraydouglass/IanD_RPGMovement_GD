extends CanvasLayer

var input_manager
var menu_parent
var show_menu: bool = true
var game_manager
var debug_scene_int = 0
var game_scene_int = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	menu_parent = $Control
	input_manager = $"../InputManager"
	game_manager = $".."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_input_pause()
	pass

func check_input_pause():
	if input_manager.is_paused == show_menu:
		return
	if input_manager.is_paused == true:
		show_menu = true
		menu_parent.set_process(true)
		menu_parent.set_visible(true)
		pass
	else:
		show_menu = false
		menu_parent.set_process(false)
		menu_parent.set_visible(false)
		pass
	pass

func _on_warp_debug_pressed():
	game_manager.world_manager.blind_respawn(debug_scene_int)
	pass # Replace with function body.


func _on_warp_game_pressed():
	game_manager.world_manager.blind_respawn(game_scene_int)
	pass # Replace with function body.


func _on_exit_game_pressed():
	if OS.get_name() == "Web":
		return
	else:
		get_tree().quit()
	pass # Replace with function body.
