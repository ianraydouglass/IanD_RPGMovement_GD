extends Node2D

var patrol_area
var patrol_zone
var patrol_index
var patrol_anchor
var character_type = "patrol point"



func _ready():
	patrol_area = $PatrolPointArea
	patrol_anchor = $"."

func set_point():
	pass

func notify_patrol_area():
	patrol_zone.patrol_point_reached(patrol_index)
	pass
