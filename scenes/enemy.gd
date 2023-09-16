extends CharacterBody2D


#movement speed and multiplier applied when sprinting
var speed: float = 100
var sprint_multi: float = 2

#the directiont the enemy is actually moving
var true_direction: Vector2 = Vector2(0,0)

var enemy_sprite

#used by SpriteAnimator node to play the correct animations
var idle_id = "s idle "
var walk_id = "skeleton move "

var sprite_animator

func _ready():
	sprite_animator = $SkeletonEnemy/AnimatedSprite2D/SpriteAnimator
	enemy_sprite = $SkeletonEnemy/AnimatedSprite2D
	enemy_sprite.play("s idle s")
	pass
func _process(delta):
	pass
