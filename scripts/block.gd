extends RigidBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var unlock_loop: AudioStreamPlayer2D = $unlock_loop
@onready var unlock_sound: AudioStreamPlayer2D = $unlock_sound
@onready var spooky_timer: Timer = $spooky_timer

@export var block_name: String = "block_1"
var is_player_in_range = false

func interaction_with_player():
	if is_player_in_range:
		print("You have no access")
		print(block_name)


func block():
	pass


func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		is_player_in_range = true


func _on_interactable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		is_player_in_range = false

func open_block():
	print("open block ",block_name)
	#Here put the dialogue on top of the screen
	#Start the shader showing
	animated_sprite_2d.stop()
	unlock_loop.play()
	unlock_sound.play()
	spooky_timer.start()


func _on_ready() -> void:
	unlock_loop.stream = Global.SOUND_LOOP_unlock_door
	unlock_sound.stream = Global.SOUND_door
	animated_sprite_2d.play()


func _on_spooky_timer_timeout() -> void:
	#Close the shader
	unlock_loop.stop()
	unlock_sound.stop()
	print("door destroyed")
	queue_free()
