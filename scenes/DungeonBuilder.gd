extends Node2D

@export var safety_size: int = 100
@export var dungeon_size: int = 30
var safety_talley: int
var dungeon_talley: int

@export var starting_corridor = "res://scenes/corridors/Room_4Way.tscn"

var all_corridors = ["res://scenes/corridors/Hall_2Way.tscn",
"res://scenes/corridors/Hall_L.tscn",
"res://scenes/corridors/Room_4Way.tscn",
"res://scenes/corridors/Room_6Way.tscn"
]

var all_entry_points = []
 
# Called when the node enters the scene tree for the first time.
func _ready():
	#any prep
	if safety_size <= 0:
		safety_size = 10
	if dungeon_size <= 0:
		dungeon_size = 1
	make_random_dungeon()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func make_random_dungeon():
	#instantiate starting area
	place_starting_room()
	#start looping
	#close holes
	pass

func place_starting_room():
	var start_room_scene = load(starting_corridor)
	var start_room = start_room_scene.instatiate()
	add_child(start_room)
	dungeon_talley = 1
	pass

func primary_room_build():
	#reset entry point list
	#pick a point
	#try to place
	
	pass
