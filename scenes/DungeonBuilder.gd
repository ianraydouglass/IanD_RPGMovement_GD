extends Node2D

@export var safety_size: int = 100
@export var dungeon_size: int = 30
var dungeon_talley: int

var starting_corridor

var all_corridors = ["res://scenes/corridors/Hall_2Way.tscn",
"res://scenes/corridors/Hall_L.tscn",
"res://scenes/corridors/Room_4Way.tscn",
"res://scenes/corridors/Room_6Way.tscn"
]

var all_entry_points = []

var all_current_rooms = []

var target_entry

var placed_entry

var rng

 
# Called when the node enters the scene tree for the first time.
func _ready():
	starting_corridor = $Room4Way #gets starting room
	all_current_rooms.append(starting_corridor)
	dungeon_talley = 1
	add_entries_from_room(starting_corridor)
	#minimum safety and dungeon values
	if safety_size <= 0:
		safety_size = 10
	if dungeon_size <= 0:
		dungeon_size = 2
	rng = RandomNumberGenerator.new()
	make_random_dungeon()
	pass # Replace with function body.

func add_entries_from_room(r):
	if !r.has_method("get_all_entries"):
		print("tried to add entries for a room that did not have them")
		return
	var entries_to_add = r.get_all_entries()
	if entries_to_add.size() == 0:
		print("room has no entry points")
		return
	for e in entries_to_add.size():
		all_entry_points.append(entries_to_add[e])
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func make_random_dungeon():
	#start looping
	for d in safety_size:
		if dungeon_talley >= dungeon_size:
			break
		select_target_entry() #sets target entry
		var incoming_corridor = select_corridor_to_place()
		if try_placing_corridor(incoming_corridor):
			dungeon_talley += 1
			var tri = all_entry_points.find(target_entry)
			if tri != -1:
				all_entry_points.remove_at(tri)
			else:
				print("failed to find target entry in all entry points")
			var pri = all_entry_points.find(placed_entry)
			if pri != -1:
				all_entry_points.remove_at(pri)
			else:
				print("failed to find paced entry in all points")
			
		pass
	
	#close holes
	pass

func select_target_entry():
	var entry_index = rng.randi_range(0, (all_entry_points.size()-1))
	target_entry = all_entry_points[entry_index]

func select_corridor_to_place():
	var corridor_index = rng.randi_range(0, (all_corridors.size()-1))
	return all_corridors[corridor_index]
	pass


func try_placing_corridor(c):
	var scene = load(c)
	var instance = scene.instantiate()
	add_child(instance)
	var incoming_entries = instance.get_all_entries()
	var target_identity = target_entry.direction_identity
	var valid_entry_points = []
	for p in incoming_entries.size():
		var ei = incoming_entries[p].direction_identity
		if test_entry_compatibility(target_identity, ei):
			valid_entry_points.append(incoming_entries[p])
	if valid_entry_points.size() == 0:
		instance.queue_free()
		return false
	var placement_index = rng.randi_range(0, (valid_entry_points.size()-1))
	placed_entry = valid_entry_points[placement_index]
	add_entries_from_room(instance)
	var position_adjustment = target_entry.global_position
	instance.global_position = position_adjustment - instance.get_entry_offset(placed_entry)
	var areas_to_test = instance.placement_area.get_overlapping_areas()
	var found_overlap = false
	if areas_to_test.size() != 0:
		print("found collisions when testing room")
		for a in areas_to_test.size():
			var area_parent = a.get_parent()
			if area_parent.is_in_group("room"):
				found_overlap = true
				break
		pass
	if found_overlap:
		instance.queue_free()
		return false
	return true

func place_starting_room():
	var scene = load(starting_corridor)
	var instance = scene.instatiate()
	add_child(instance)
	dungeon_talley = 1
	pass

func test_entry_compatibility(a, b):
	if a == "n" && b == "s":
		return true
	if a == "s" && b == "n":
		return true
	if a == "w" && b == "e":
		return true
	if a == "e" && b == "w":
		return true
	return false

func primary_room_build():
	#reset entry point list
	#pick a point
	#try to place
	
	pass
