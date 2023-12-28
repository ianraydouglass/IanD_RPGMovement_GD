extends Area2D


const flame_damage = 1

var flame: bool = false
var current_beat: int = 0
var animation_tree: AnimationTree
var state_machine
var player_object
var is_player_within: bool = false
var position_anchor
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree = $AnimationTree
	state_machine = animation_tree["parameters/playback"]
	connect("area_entered", register_other)
	connect("area_exited", clear_other)
	position_anchor = $PositionAnchor
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_player_within and player_object != null and flame == true:
		#we want to snap the knockback to a direction, so we add true
		player_object.take_damage(flame_damage, position_anchor.global_position, true)

func recieve_beat(b):
	if current_beat == b:
		return
	current_beat = b
	resolve_beat()

func resolve_beat():
	if current_beat >= 9 && current_beat <= 12:
		state_machine.travel("warning_jet")
		return
	if current_beat >= 13:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_jet"] = true
		flame = true
	else:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_jet"] = false
		flame = false
	if current_beat >= 5 && current_beat <= 9:
		state_machine.travel("pulse_jet")
		
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
