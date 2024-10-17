extends Node2D
@onready var player: CharacterBody2D = $player


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
