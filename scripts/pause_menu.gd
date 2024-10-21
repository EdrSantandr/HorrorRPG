extends CanvasLayer


func _ready() -> void:
	visible = false

func _on_resume_button_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_option_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
