extends Node2D

@export var north_entry = []
@export var south_entry = []
@export var east_entry = []
@export var west_entry = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func has_north():
	var verdict = false
	if north_entry.size() > 0:
		verdict = true
	return verdict

func has_south():
	var verdict = false
	if south_entry.size() > 0:
		verdict = true
	return verdict
	
func has_east():
	var verdict = false
	if east_entry.size() > 0:
		verdict = true
	return verdict
	
func has_west():
	var verdict = false
	if west_entry.size() > 0:
		verdict = true
	return verdict
