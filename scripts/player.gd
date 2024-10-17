extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $animated_sprite
@onready var timer_enemy_cooldown: Timer = $timer_enemy_cooldown

var enemy_in_attack_range: bool = false
var enemy_attack_cooldown: bool = true
var health: int = 100
var player_alive: bool = true
var attack_state: bool = false

const SPEED: float = 100
var direction: int = 0 #means no direction
var previous_direction: int = 4
var previous_velocity: Vector2 = Vector2(0,0)
var previous_idle_animation: String = "front_idle"
var enemy: CharacterBody2D = null

func _physics_process(delta: float) -> void:
	player_movement(delta)
	enemy_attack()
	
	if health <= 0:
		player_alive = false # restart game
		health = 0
		print("Player has been killed")
		self.queue_free()
	
func player_movement(delta: float):
	if Input.is_action_pressed("move_right"):
		# 1 means right animation
		direction = 1
		previous_direction = direction
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		# 2 means left animation
		direction = 2
		previous_direction = direction
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_top"):
		# 3 means top animation
		direction = 3
		previous_direction = direction
		velocity.x = 0
		velocity.y = -SPEED
	elif Input.is_action_pressed("move_bottom"):
		# 4 means bottom animation
		direction = 4
		previous_direction = direction
		velocity.x = 0
		velocity.y = SPEED
	else:
		direction = 0
		velocity.x = 0
		velocity.y = 0
	
	play_direction_animation(direction, previous_velocity)
	move_and_slide()
	previous_velocity = velocity
	attack_state = Input.is_action_just_released("attack")	
	play_attack_animation(previous_direction)


func play_attack_animation(direction: int):
	if attack_state:
		Global.player_current_attack = true
		if direction == 1:
			animated_sprite.flip_h = false
			animated_sprite.play("side_attack")
		elif direction == 2:
			animated_sprite.flip_h = true
			animated_sprite.play("side_attack")
		elif direction == 3:
			animated_sprite.play("back_attack")
		elif direction == 4:
			animated_sprite.play("front_attack")
		# Handle damage to enemy
		if enemy!= null && enemy_in_attack_range:
			enemy.handle_damage()
		animated_sprite.animation_finished.connect(attack_animation_finished)


func play_direction_animation(direction: int, previous_velocity: Vector2):
	# Region to handle walking
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

	# Region to handle idle
	if direction == 0 && !attack_state:
		var anim_to_play: String = "front_idle"
		if  (abs(previous_velocity.x)!=0 || abs(previous_velocity.y)!=0):
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
			previous_idle_animation = anim_to_play
			animated_sprite.play(anim_to_play)


func player():
	pass


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = true
		enemy = body


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = false
		enemy = null


func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown:
		health -= 5
		enemy_attack_cooldown = false
		timer_enemy_cooldown.start()


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true


func attack_animation_finished():
	attack_state = false
	Global.player_current_attack = false
	animated_sprite.stop()
	animated_sprite.play(previous_idle_animation)
	
