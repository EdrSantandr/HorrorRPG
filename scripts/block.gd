extends RigidBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

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
	queue_free()
