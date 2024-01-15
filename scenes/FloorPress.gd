extends Area2D

@export var must_hold: bool = false
var animation_tree: AnimationTree
var state_machine

var current_press_state: bool = false
var currently_within = []
var switch_hidden = false
@export var listener: Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", register_other)
	connect("area_exited", clear_other)
	connect("body_entered", register_other)
	connect("body_exited", clear_other)
	animation_tree = $AnimationTree
	state_machine = animation_tree["parameters/playback"]
	refresh_sprite()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currently_within.size() > 0:
		see_press()
	else:
		see_empty()
	pass

func see_press():
	if current_press_state == false:
		current_press_state = true
		print("button pressed")
		if listener != null:
			listener.recieve_state(true)
		refresh_sprite()
	pass

func see_empty():
	if current_press_state == true and must_hold == true:
		current_press_state = false
		print("button un-pressed")
		if listener != null:
			listener.recieve_state(false)
		refresh_sprite()
	pass

func unhide_switch():
	switch_hidden = false
	refresh_sprite()

func toggle_state():
	if must_hold == true:
		return
	if currently_within.size() > 0:
		return
	if current_press_state == true:
		see_empty()
	else:
		see_press()
	pass


func refresh_sprite():
	if switch_hidden == true:
		state_machine.travel("hidden")
		return
	if must_hold == false:
		if current_press_state == false:
			state_machine.travel("switch_neutral")
			return
		else: #pressed
			state_machine.travel("switch_pressed")
			return
		pass
	else: #must hold is true
		if current_press_state == false:
			state_machine.travel("button_neutral")
			return
		else: #pressed
			state_machine.travel("button_pressed")
			return
		pass
	pass

func register_other(other):
	if other.has_method("check_player"):
		return
	if other.has_method("trigger_switch"):
		if currently_within.has(other):
			print("floor press avoided adding a dupe reference")
		else:
			currently_within.append(other)
	else:
		var character_object = other.get_owner()
		if character_object.has_method("trigger_switch"):
			if currently_within.has(other):
				print("floor press avoided adding a dupe reference")
			else:
				currently_within.append(other)

func clear_other(other):
	if other.has_method("trigger_switch"):
		if currently_within.has(other):
			var clear_index = currently_within.find(other)
			currently_within.remove_at(clear_index)
	else:
		var character_object = other.get_owner()
		if character_object.has_method("trigger_switch"):
			if currently_within.has(other):
				var clear_index = currently_within.find(other)
				currently_within.remove_at(clear_index)
