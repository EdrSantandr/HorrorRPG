extends Control
@onready var options: Control = $Options

func _ready() -> void:
	options.visible = false

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/outside.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_options_button_pressed() -> void:
	options.visible = true
