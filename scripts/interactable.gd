extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $RigidBody2D/AnimatedSprite2D
@export var sprite_frames: SpriteFrames
@onready var interact_sound: AudioStreamPlayer2D = $interact_sound
@export var interact_sound_stream: AudioStream

var is_player_in_range:bool = false
var is_player_already_interacted: bool = false
@export var object_name: String = "object_a"
@onready var dialogue_area: Area2D = %DialogueArea

func _on_body_entered(body: Node2D) -> void:
	if !is_player_already_interacted:
		is_player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if !is_player_already_interacted:
		is_player_in_range = false


func interaction_with_player():
	if is_player_in_range && !is_player_already_interacted:
		animated_sprite_2d.play("idle")
		interact_sound.play()
		Global.update_interaction_objects(object_name)
		remove_child(dialogue_area)
		interact()
		is_player_already_interacted = true

func interact() -> void:
	pass

func interactable():
	pass


func _on_ready() -> void:
	if sprite_frames != null:
		animated_sprite_2d.sprite_frames = sprite_frames
	if interact_sound_stream != null:
		interact_sound.stream = interact_sound_stream
	interact_sound.bus = &"SFX"
