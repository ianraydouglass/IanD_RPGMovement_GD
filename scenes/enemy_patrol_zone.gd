extends Node2D

var all_patrol_points = []
var current_target_index
@export var this_enemy: CharacterBody2D
var character_type = "patrol zone"
var player_object
var center_point

# Called when the node enters the scene tree for the first time.
func _ready():
	current_target_index = 0
	set_patrol_points()
	set_enemy_reference()
	center_point = get_center_point()
	
	

func set_patrol_points():
	for c in get_children():
		if c.has_method("notify_patrol_area"):
			all_patrol_points.append(c)
			print("added point " + c.name)
	if all_patrol_points.size() == 0:
		return
	for i in all_patrol_points.size():
		all_patrol_points[i].patrol_zone = self
		all_patrol_points[i].patrol_index = i
	
func set_enemy_reference():
	if this_enemy != null:
		this_enemy.patrol_zone = self
		if all_patrol_points.size() > 0:
			this_enemy.current_patrol_target = all_patrol_points[0]
		this_enemy.set_mode_state("patrol")#this starts their patrol movement
		
func patrol_point_reached(p: int):
	if p != current_target_index:#we don't want it to accidentally check-in on the way
		return
	if this_enemy.mode_state != "patrol" && this_enemy.mode_state != "return":
		return#we don't want to trigger this if the enemy isn't patrolling
	var new_index = p+1#seeing what the next index would be
	if new_index >= all_patrol_points.size():#overlap if at end of index
		new_index = 0
	current_target_index = new_index
	this_enemy.current_patrol_target = all_patrol_points[new_index]
	this_enemy.set_mode_state("patrol")#if they were in return mode, we want them in patrol mode now
	return
# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_center_point():
	var output_position: Vector2 = Vector2(0,0)
	if all_patrol_points.size() == 0:
		return output_position
	for i in all_patrol_points.size():
		output_position += all_patrol_points[i].global_position
	output_position = output_position / all_patrol_points.size()
	return output_position

func get_nearest_point(p):
	var output_position: Vector2 = Vector2(0,0)
	var current_dist: float = -1
	if all_patrol_points.size() == 0:
		return output_position
	for i in all_patrol_points.size():
		var relative_dist: float = all_patrol_points[i].global_position.distance_to(p)
		if current_dist == -1 || relative_dist < current_dist:
			output_position = all_patrol_points[i].global_position
			current_dist = relative_dist
	return output_position

func is_point_within_zone(p):
	var verdict = false
	if all_patrol_points.size() == 0:
		return verdict
	var near_point = get_nearest_point(p)
	var near_dist = near_point.distance_to(center_point)
	var center_dist = center_point.distance_to(p)
	if center_dist < near_dist:
		verdict = true
	return verdict
