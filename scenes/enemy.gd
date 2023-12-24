extends CharacterBody2D


#movement speed and multiplier applied when sprinting
var speed: float = 100
var sprint_multi: float = 2

#read by area 2d scripts to ensure they are hitting the right thing
const character_type = "enemy"

#variables for patrol zone and behavior to read
var mode_state = "idle"
var patrol_zone
var current_patrol_target

#the directiont the enemy is actually moving
var true_direction: Vector2 = Vector2(0,0)

var enemy_sprite

#used by SpriteAnimator node to play the correct animations
var idle_id = "s idle "
var walk_id = "skeleton move "

var is_moving = false

var sprite_animator

var position_anchor

func _ready():
	sprite_animator = $SkeletonEnemy/AnimatedSprite2D/SpriteAnimator
	enemy_sprite = $SkeletonEnemy/AnimatedSprite2D
	position_anchor = $PositionAnchor
	enemy_sprite.play("s idle s")
	pass
func _process(delta):
	move_enemy(delta)
	pass
	
func move_enemy(delta):
	#move the player based on speed, input, and sprint multiplier
	var current_speed: float = speed
	var move_direction: Vector2 = Vector2(0,0)
	if mode_state == "idle":
		current_speed = 0
	if mode_state == "patrol" && current_patrol_target != null:
		var align_vector = ( current_patrol_target.global_position - position_anchor.global_position ).normalized()
		move_direction = align_vector
	#other speed modifications
	if move_direction != Vector2(0,0):
		is_moving = true
	else:
		is_moving = false
	velocity = move_direction * current_speed
	move_and_slide()
	#set_true_direction()
