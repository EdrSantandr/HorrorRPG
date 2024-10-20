extends Node2D
@onready var ambience_outside: AudioStreamPlayer = $ambience_outside


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ambience_outside.stream = Global.SOUND_ambience_outside
	ambience_outside.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_transition_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.is_transition_scene = true
		change_scene(body)

func change_scene(body: Node2D):
	if Global.is_transition_scene:
		if Global.current_scene == "world":
			ambience_outside.stop()
			Global.scene_changed(body)
			get_tree().change_scene_to_file("res://scenes/mansion.tscn")
