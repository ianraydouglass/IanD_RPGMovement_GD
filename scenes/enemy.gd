extends CharacterBody2D


#movement speed and multiplier applied when sprinting
var speed: float = 100
var patrol_speed: float = 75
var chase_speed: float = 100
var return_speed: float = 150
const pursuit_distance: float = 300

#read by area 2d scripts to ensure they are hitting the right thing
const character_type = "enemy"

#variables for patrol zone and behavior to read
var mode_state = "idle"
var patrol_zone
var current_patrol_target

#variables for chasing the player
var player_object

const gloat_time = 1.5
var g_timer

#the directiont the enemy is actually moving
var true_direction: Vector2 = Vector2(0,0)

var enemy_sprite

#used by SpriteAnimator node to play the correct animations
var idle_id = "s idle "
var walk_id = "skeleton move "

var is_moving = false

var sprite_animator

var position_anchor

var look_direction: Vector2 = Vector2(0,0)

func _ready():
	sprite_animator = $SkeletonEnemy/AnimatedSprite2D/SpriteAnimator
	enemy_sprite = $SkeletonEnemy/AnimatedSprite2D
	position_anchor = $PositionAnchor
	enemy_sprite.play("s idle s")
	g_timer = $GTimer
	pass
func _process(delta):
	move_enemy(delta)
	pass
	
func move_enemy(delta):
	#move the player based on speed, input, and sprint multiplier
	var current_speed: float = speed
	var move_direction: Vector2 = Vector2(0,0)
	if !can_pursue() && mode_state == "chase":
		set_mode_state("return")
	if mode_state == "idle":
		current_speed = 0
	if mode_state == "patrol" && current_patrol_target != null:
		var align_vector = ( current_patrol_target.global_position - position_anchor.global_position ).normalized()
		move_direction = align_vector
		current_speed = patrol_speed
	if mode_state == "return" && current_patrol_target != null:
		var align_vector = ( current_patrol_target.global_position - position_anchor.global_position ).normalized()
		move_direction = align_vector
		current_speed = return_speed
	if mode_state == "chase" && player_object != null:
		var align_vector = ( player_object.position_anchor.global_position - position_anchor.global_position ).normalized()
		move_direction = align_vector
		current_speed = chase_speed
	if mode_state == "gloat":
		current_speed = 0
	if move_direction != Vector2(0,0):
		is_moving = true
		set_look_direction(move_direction)#if he's moving we want him looking where he's moving
	else:
		is_moving = false
	velocity = move_direction * current_speed
	move_and_slide()
	#set_true_direction()
func set_look_direction(d):
	look_direction = d

func on_hit_player():
	if mode_state == "gloat":
		return
	set_mode_state("gloat")
	g_timer.set_wait_time(gloat_time)
	g_timer.start()

func gloat_end():
	if can_pursue():
		set_mode_state("chase")
	else:
		set_mode_state("return")
	
	pass

func set_mode_state(m):
	if mode_state != m:
		print("mode state change from " + mode_state + " to " + m)
		mode_state = m

func can_pursue():
	var verdict = false
	if player_object == null || patrol_zone == null:
		return verdict
	var zone_distance = player_object.position_anchor.global_position.distance_to(patrol_zone.global_position)
	if zone_distance <= pursuit_distance:
		verdict = true
	return verdict

func _on_g_timer_timeout():
	print("gloat timer end")
	gloat_end()
	pass # Replace with function body.
