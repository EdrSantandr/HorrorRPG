extends CanvasLayer

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	visible = false
