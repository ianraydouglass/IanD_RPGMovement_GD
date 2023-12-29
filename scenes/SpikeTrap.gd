extends Area2D

const spike_damage = 1
var animation_tree: AnimationTree
@export var spikes_out: bool = false
var body_shape
var position_anchor
var player_object
var is_player_within
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree = $AnimationTree
	body_shape = $StaticBody2D/CollisionShape2D
	position_anchor = $Position_anchor
	connect("area_entered", register_other)
	connect("area_exited", clear_other)
	check_spike_state()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_player_within == true and spikes_out == true:
		player_object.take_damage(spike_damage, position_anchor.global_position, true)
	pass

func check_spike_state():
	if spikes_out == true:
		shoot_spike()
	else:
		retract_spike()
		
func toggle_spike():
	if spikes_out == true:
		spikes_out = false
	else:
		spikes_out = true
	check_spike_state()

func toggle_state():
	toggle_spike()

func set_spike_state(b):
	if b == spikes_out:
		return
	else:
		spikes_out = b
		check_spike_state()

func shoot_spike():
	body_shape.disabled = false
	animation_tree["parameters/conditions/hide"] = false
	animation_tree["parameters/conditions/shoot"] = true

func retract_spike():
	body_shape.disabled = true
	animation_tree["parameters/conditions/shoot"] = false
	animation_tree["parameters/conditions/hide"] = true
	
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
