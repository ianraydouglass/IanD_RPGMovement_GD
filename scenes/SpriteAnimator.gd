extends Node2D

var character_script
var character_sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	character_script = $"../../.."
	character_sprite = $".."



func blink_state(o: bool):
	if o:
		character_sprite.modulate.a = 1
	else:
		character_sprite.modulate.a = 0
#the character or enemy will call one of these functions passing a float
func play_idle_y(v: float):
	if v <= 0:
		character_sprite.play(character_script.idle_id + "n")
		#play idle north
		
	else:
		character_sprite.play(character_script.idle_id + "s")
		#play idle south
			
func play_idle_x(v: float):
	if v <= 0:
		character_sprite.play(character_script.idle_id + "w")
		#play idle west
		
	else:
		character_sprite.play(character_script.idle_id + "e")
		#play idle east

#the character or enemy will call this function passing a string
func play_walk(d):
	if d == "north":
		character_sprite.play(character_script.walk_id + "north")
	if d == "south":
		character_sprite.play(character_script.walk_id + "south")
	if d == "west":
		character_sprite.play(character_script.walk_id + "west")
	if d == "east":
		character_sprite.play(character_script.walk_id + "east")
