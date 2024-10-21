extends Control

@onready var label: Label = $HBoxContainer/Label
@onready var button: Button = $HBoxContainer/Button

@export var action_name: String = ""

func _ready() -> void:
	#set_process_unhandled_key_input(false)
	set_action_name()

func  set_action_name() -> void:
	label.text = action_name.replace("_", " ").capitalize()
