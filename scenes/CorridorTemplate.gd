extends Node2D

@export var north_entry: Array[Node2D] = []
@export var south_entry: Array[Node2D] = []
@export var east_entry: Array[Node2D] = []
@export var west_entry: Array[Node2D] = []

var placement_area
# Called when the node enters the scene tree for the first time.
func _ready():
	placement_area = $Area2D
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

func get_all_entries():
	var verdict = []
	if has_north():
		for n in north_entry.size():
			verdict.append(north_entry[n])
	if has_south():
		for s in south_entry.size():
			verdict.append(south_entry[s])
	if has_east():
		for e in east_entry.size():
			verdict.append(east_entry[e])
	if has_west():
		for w in west_entry.size():
			verdict.append(west_entry[w])
	return verdict

func get_entry_offset(e):
	var this_pos: Vector2 = global_position
	var entry_point: Vector2 = e.global_position
	var output: Vector2 = this_pos + entry_point
	return output
