extends Node2D
@onready var player: CharacterBody2D = $player
@onready var spawn_shader_timer: Timer = $spawn_shader_timer
@onready var material_shader_timer: Timer = $material_shader_timer

var shader_instance = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.position = Global.player_start_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cliffside_transition_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.has_method("player"):
		Global.is_transition_scene = true
		change_scene(body)

func _on_cliffside_transition_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.has_method("player"):
		Global.is_transition_scene = false


func change_scene(body: Node2D):
	if Global.is_transition_scene:
		if Global.current_scene == "world":
			Global.scene_changed(body)
			get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")  #Recommend to set the change of scene at the end


func _on_spawn_shader_timer_timeout() -> void:
	var scene = load("res://scenes/tests/shader_test_1.tscn")
	var instance = scene.instantiate()
	shader_instance = instance
	add_child(instance)
	material_shader_timer.start()


func _on_material_shader_timer_timeout() -> void:
	if (shader_instance !=null):
		var shader_color_rect: ColorRect = shader_instance as ColorRect
		var custom_material: Sprite2D = shader_color_rect.get_child(0, true) as Sprite2D
		var full_image = custom_material.material
		full_image.set_shader_parameter("is_full_image", true)
	
