extends Node2D

var input_manager

#movement speed and multiplier applied when sprinting
var speed: float = 100
var sprint_multi: float = 2
#something that can halt the player if needed
var can_move: bool = true
#a variable that tracks if the player is moving via input currently for animation
var is_moving: bool = false
#the directiont the player is actually moving, not just the input direction
var true_direction: Vector2 = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
var player_sprite

var current_direction = "none"

#used by SpriteAnimator node to play the correct animations
var idle_id = "p idle "
var walk_id = "player "

var sprite_animator

func _ready():
	#get a reference to the input manager
	input_manager = $"../InputManager"
	player_sprite = $PlayerCharacter/PlayerCharacterSprite
	player_sprite.play("p idle s")
	sprite_animator = $PlayerCharacter/PlayerCharacterSprite/SpriteAnimator


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#move the player based on speed, input, and sprint multiplier
	var current_speed: float = speed
	if input_manager.is_sprinting:
		current_speed = speed * sprint_multi
	if can_move:
		if input_manager.move_direction != Vector2(0,0):
			is_moving = true
		else:
			is_moving = false
		position += input_manager.move_direction * current_speed * delta
		set_true_direction()
	else:
		#we want to make extra sure that the player doesn't forget that they aren't moving
		is_moving = false
		set_true_direction()
		

func freeze_player():
	can_move = false
	is_moving = false
	
#used to toggle the animation between idle
func set_true_direction():
	if(is_moving):
		true_direction = input_manager.move_direction
		var new_direction = walk_to_vector(true_direction)
		if new_direction != current_direction:
			sprite_animator.play_walk(new_direction)
			current_direction = new_direction
		#check if we are playing the right moving animation
		#play the correct one if the current one doesn't match the vector
	else:
		#if the player stops moving, we should play the idle animation that corresponds to the last moved direction
		if(true_direction != Vector2 (0,0)):
			idle_to_vector(true_direction)
		true_direction = Vector2 (0,0)
		
func idle_to_vector(last_direction: Vector2):
	current_direction = "none"
	var idle_x = last_direction.x
	var idle_y = last_direction.y
	#figure out which component of the vector is stronger
	if idle_x < 0:
		idle_x = idle_x * -1
	if idle_y < 0:
		idle_y = idle_y * -1
	if idle_y >= idle_x:
		sprite_animator.play_idle_y(last_direction.y)
	else:
		sprite_animator.play_idle_x(last_direction.x)
	
func walk_to_vector(last_direction: Vector2):
	var idle_x = last_direction.x
	var idle_y = last_direction.y
	var check_direction = "none"
	#figure out which component of the vector is stronger
	if idle_x < 0:
		idle_x = idle_x * -1
	if idle_y < 0:
		idle_y = idle_y * -1
	if idle_y >= idle_x:
		check_direction = play_walk_y(last_direction.y)
	else:
		check_direction = play_walk_x(last_direction.x)
	return check_direction
	
func play_walk_y(v: float):
	if v <= 0:
		return "north"
		
	else:
		return "south"
		
func play_walk_x(v: float):
	if v <= 0:
		return "west"
		
	else:
		return "east"
		
