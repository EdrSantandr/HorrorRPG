extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var speed:float = 60
var player_chase: bool = false
var player: CharacterBody2D = null

func _physics_process(delta: float) -> void:
	if player_chase:
		position += (player.position - position)/speed
		animated_sprite_2d.play("walk")
		if (player.position.x - position.x) < 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
		move_and_collide(Vector2(0,0))
	else:
		animated_sprite_2d.play("idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
