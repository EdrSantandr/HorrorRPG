extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $animated_sprite

const SPEED: float = 100
var direction: int = 0 #means no direction
var previous_velocity: Vector2 = Vector2(0,0)

func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func player_movement(delta: float):
	if Input.is_action_pressed("move_right"):
		# 1 means right animation
		direction = 1
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		# 2 means left animation
		direction = 2
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_top"):
		# 3 means top animation
		direction = 3
		velocity.x = 0
		velocity.y = -SPEED
	elif Input.is_action_pressed("move_bottom"):
		# 4 means bottom animation
		direction = 4
		velocity.x = 0
		velocity.y = SPEED
	else:
		direction = 0
		velocity.x = 0
		velocity.y = 0
	
	play_direction_animation(direction, previous_velocity)
	move_and_slide()
	previous_velocity = velocity

func play_direction_animation(direction: int, previous_velocity: Vector2):
	if direction == 1 || direction == 2:
		if velocity.x > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("side_walk")
		elif velocity.x < 0:
			animated_sprite.flip_h = true
			animated_sprite.play("side_walk")
	elif direction == 3 || direction == 4:
		if velocity.y > 0:			
			animated_sprite.play("front_walk")
		elif velocity.y < 0:			
			animated_sprite.play("back_walk")

	if direction == 0 && (abs(previous_velocity.x)!=0 || abs(previous_velocity.y)!=0):
		var anim_to_play: String = "front_idle"
		if previous_velocity.x > 0:
			animated_sprite.flip_h = false
			anim_to_play = "side_idle"
		elif previous_velocity.x < 0:
			animated_sprite.flip_h = true
			anim_to_play = "side_idle"
		elif previous_velocity.y < 0:
			anim_to_play = "back_idle"
		elif previous_velocity.y > 0:
			anim_to_play = "front_idle"
		animated_sprite.play(anim_to_play)
