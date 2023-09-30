extends CharacterBody2D

var input_manager

var game_manager

#movement speed and multiplier applied when sprinting
const speed: float = 100
const sprint_multi: float = 1.5

#read by area 2d scripts to ensure they are hitting the right thing
const character_type = "player"

#something that can halt the player if needed
var can_move: bool = true
#a variable that tracks if the player is moving via input currently for animation
var is_moving: bool = false
#the directiont the player is actually moving, not just the input direction
var true_direction: Vector2 = Vector2(0,0)

var player_sprite

var current_direction = "none"

#used by SpriteAnimator node to play the correct animations
var idle_id = "p idle "
var walk_id = "player "

var sprite_animator

var position_anchor

const max_health: int = 5
var current_health: int

var is_invulnerable: bool = false
const invulnerability_time = 1.5
var i_timer

var is_knocked_back: bool = false
const knock_back_time: float = 0.15
const knock_back_speed: float = 300
var knock_back_vector: Vector2
#use friction later to decelerate the knockback
const knock_back_friction: float = 0.2
var k_timer

const blink_time: float = 0.1
var blink_state: bool = true
var b_timer

#reference to the LifeDisplay scene in the hud
var life_object

func _ready():
	game_manager = $".."
	#get a reference to the input manager
	input_manager = $"../InputManager"
	player_sprite = $PlayerCharacter/PlayerCharacterSprite
	player_sprite.play("p idle s")
	sprite_animator = $PlayerCharacter/PlayerCharacterSprite/SpriteAnimator
	change_health(max_health)
	i_timer = $ITimer
	k_timer = $KTimer
	b_timer = $BTimer
	position_anchor = $PositionAnchor


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move and !is_knocked_back:
		move_player(delta)
	elif is_knocked_back:
		knock_back_player(delta)
	else:
		#we want to make extra sure that the player doesn't forget that they aren't moving
		is_moving = false
		set_true_direction()
		
#this will be used when the player is voluntarally moving
func move_player(delta):
	#move the player based on speed, input, and sprint multiplier
	var current_speed: float = speed
	if input_manager.is_sprinting:
		current_speed = speed * sprint_multi
	if input_manager.move_direction != Vector2(0,0):
		is_moving = true
	else:
		is_moving = false
	velocity = input_manager.move_direction * current_speed
	move_and_slide()
	set_true_direction()

#this will be used instead of move to process knockback
func knock_back_player(delta):
	velocity = knock_back_vector * knock_back_speed
	move_and_slide()

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
		
func change_health(h: int):
	if current_health == h:
		return
	if current_health < h:
		#do animations based on damage
		current_health = h
		print("health is now " + str(current_health))
		pass
	if current_health > h:
		#do animations based on heal
		current_health = h
		print("health is now " + str(current_health))
		pass
	if life_object != null:
		life_object.life_change(h)
	pass

#d is the damage, s is the source's position
func take_damage(d: int, s: Vector2, snap: bool):
	if is_invulnerable:
		#print("damage not dealt due to invulnerable")
		return
	if d < 0:
		print("damage value can not be negative")
		return
	if is_player_dead():
		#print("player is dead and can't take damage")
		return
	var new_health = current_health - d
	if new_health <= 0:
		change_health(0)
		#damage routine
		kill_player()
	else:
		invulnerable_start()
		change_health(new_health)
		#if we want to snap the pushback direction to an axis
		if snap:
			var push_direction = position_anchor.global_position - s
			push_direction = push_direction.normalized()
			var x_comp = push_direction.x
			var y_comp = push_direction.y
			#figure out which component of the vector is stronger
			if x_comp < 0:
				x_comp = x_comp * -1
			if y_comp < 0:
				y_comp = y_comp * -1
			if y_comp > x_comp:
				push_direction.x = 0
			else:
				push_direction.y = 0
			knock_back_start(push_direction.normalized())
		#otherwise we want to push the player directly away from the source
		else:
			
			var push_direction = position_anchor.global_position - s
			knock_back_start(push_direction.normalized())
		#damage routine

func knock_back_start(v: Vector2):
	if is_knocked_back:
		return
	knock_back_vector = v
	is_knocked_back = true
	k_timer.set_wait_time(knock_back_time)
	k_timer.start()
	
func knock_back_end():
	if !is_knocked_back:
		return
	is_knocked_back = false

func invulnerable_start():
	if is_invulnerable:
		return
	is_invulnerable = true
	i_timer.set_wait_time(invulnerability_time)
	i_timer.start()
	b_timer.set_wait_time(blink_time)
	b_timer.start()
	
	
func invulnerable_end():
	is_invulnerable = false
	b_timer.stop()
	blink_state = true
	sprite_animator.blink_state(true)

func is_player_dead():
	var verdict: bool = false
	if current_health <= 0:
		verdict = true
	return verdict

func heal_damage(h: int):
	if h < 0:
		print("healing can not be negative")
	var new_health = current_health + h
	if new_health > max_health:
		new_health = max_health
	change_health(new_health)
	#healing routine
func toggle_blink():
	if blink_state:
		sprite_animator.blink_state(false)
		blink_state = false
	else:
		sprite_animator.blink_state(true)
		blink_state = true

func kill_player():
	print("player is dead")
	revive_player()
	pass

func revive_player():
	invulnerable_start()
	change_health(5)
	self.global_transform = game_manager.check_point_manager.respawn_location
	pass

func _on_i_timer_timeout():
	print("invulnerable ended")
	invulnerable_end()



func _on_k_timer_timeout():
	knock_back_end()


func _on_b_timer_timeout():
	toggle_blink()
