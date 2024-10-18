extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $health_bar

var speed:float = 60
var player_chase: bool = false
var player: CharacterBody2D = null

var player_in_attack_range: bool = false
var health: int = 100
var enemy_alive: bool = true


func _physics_process(delta: float) -> void:
	update_health()
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
	
	
func enemy():
	pass


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_range = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_range = false


func handle_damage():
	if player_in_attack_range and Global.player_current_attack:
		health -= 20
		print("slime health = ", health)
		if health <= 0:
			self.queue_free()
			

func update_health():
	health_bar.value = health
	if health >= 100:
		health_bar.visible = false
	else:
		health_bar.visible = true
