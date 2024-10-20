extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $animated_sprite
@onready var timer_enemy_cooldown: Timer = $timer_enemy_cooldown
@onready var world_camera: Camera2D = $world_camera
@onready var mansion_camera: Camera2D = $mansion_camera
@onready var health_bar: ProgressBar = $health_bar
@onready var footstep_sound: AudioStreamPlayer2D = $FootstepSound

@export var stepsounds = []

var health: int = 100
var player_alive: bool = true
var attack_state: bool = false
var last_player_position: Vector2 = Vector2(0,0)

var interact_state: bool = false
var interactable_object: Area2D = null
var interactable_in_range: bool = false

var block_object: RigidBody2D = null
var block_in_range: bool = false


const SPEED: float = 100
var direction: int = 0 #means no direction
var previous_direction: int = 4
var previous_velocity: Vector2 = Vector2(0,0)
var previous_idle_animation: String = "ghost_front_idle"
var enemy: CharacterBody2D = null

func _physics_process(delta: float) -> void:
	player_movement(delta)
	current_camera()
	update_health()
	
	if health <= 0:
		player_alive = false # restart game
		health = 0
		print("Player has been killed")
		self.queue_free()


func player_movement(delta: float):
	var input_direction = Input.get_vector("move_left", "move_right", "move_top", "move_bottom")
	if input_direction.x > 0:
		direction = 1
	elif input_direction.x < 0:
		direction = 2
	elif input_direction.y < 0:
		direction = 3
	elif  input_direction.y > 0:
		direction = 4
	else :
		direction = 0 
	velocity = input_direction * SPEED
	
	if velocity.length() != 0:
		if !footstep_sound.playing:
			footstep_sound.stream = stepsounds.pick_random()
			footstep_sound.pitch_scale = randf_range(0.8, 1.2)
			footstep_sound.play()
	
	play_direction_animation(direction, previous_velocity)
	move_and_slide()
	previous_velocity = velocity
	
	interact_state = Input.is_action_just_released("interaction")
	if interact_state:
		handle_interaction()


func handle_interaction():
	if interactable_in_range && interactable_object != null:
		print(interactable_object.name)
		interactable_object.interaction_with_player()
	elif block_in_range && block_object != null:
		print(block_object.name)
		block_object.interaction_with_player()
	

func play_direction_animation(direction: int, previous_velocity: Vector2):
	# Region to handle walking
	if direction == 1 || direction == 2:
		if velocity.x > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("ghost_side_walk")
		elif velocity.x < 0:
			animated_sprite.flip_h = true
			animated_sprite.play("ghost_side_walk")
	elif direction == 3 || direction == 4:
		if velocity.y > 0:			
			animated_sprite.play("ghost_front_walk")
		elif velocity.y < 0:			
			animated_sprite.play("ghost_back_walk")

	# Region to handle idle
	if direction == 0 && !attack_state:
		var anim_to_play: String = "ghost_front_idle"
		if  (abs(previous_velocity.x)!=0 || abs(previous_velocity.y)!=0):
			if previous_velocity.x > 0:
				animated_sprite.flip_h = false
				anim_to_play = "ghost_side_idle"
			elif previous_velocity.x < 0:
				animated_sprite.flip_h = true
				anim_to_play = "ghost_side_idle"
			elif previous_velocity.y < 0:
				anim_to_play = "ghost_back_idle"
			elif previous_velocity.y > 0:
				anim_to_play = "ghost_front_idle"
			previous_idle_animation = anim_to_play
			animated_sprite.play(anim_to_play)


func player():
	pass


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("interactable"):
		interactable_in_range = false
		interactable_object = null


func current_camera():
	if Global.current_scene == "world":
		world_camera.enabled = true
		mansion_camera.enabled = false
	elif Global.current_scene == "mansion":
		world_camera.enabled = false
		mansion_camera.enabled = true

func update_health():
	health_bar.value = health
	if health >= 100:
		health_bar.visible = false
	else:
		health_bar.visible = true


func _on_health_regen_timer_timeout() -> void:
	if health < 100:
		health += 5
	health = clamp(health, 0, 100)


func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if area.has_method("interactable"):
		interactable_in_range = true
		interactable_object = area
	elif area.get_parent().has_method("block"):
		block_in_range = true
		block_object = area.get_parent()


func _on_player_hitbox_area_exited(area: Area2D) -> void:
	if area.has_method("interactable"):
		interactable_in_range = false
		interactable_object = null
	elif area.get_parent().has_method("block"):
		block_in_range = false
		block_object = null
