extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_scenes(body: Node2D):
	if Global.is_transition_scene:
		if Global.current_scene == "cliff_side":
			Global.scene_changed(body)
			get_tree().change_scene_to_file("res://scenes/world.tscn")
