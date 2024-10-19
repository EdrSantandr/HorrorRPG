extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_player_in_range:bool = false
@export var object_name: String = "object_a"

func _on_body_entered(body: Node2D) -> void:
	print("body entered")
	is_player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	print("body out")
	is_player_in_range = false


func interaction_with_player():
	print("player interacting")
	animated_sprite_2d.play("idle")
	Global.update_interaction_objects(object_name)


func interactable():
	pass
