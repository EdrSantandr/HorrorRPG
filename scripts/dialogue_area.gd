extends Area2D

@export var dialogue_key = ""
@export var area_name = ""
var area_active = false

@onready var label: Label = %AreaLabel

func _ready() -> void:
	label.visible = false
	label.text = area_name

func _input(event):
	if area_active and event.is_action_pressed("interaction"):
		SignalBus.emit_signal("display_dialogue", dialogue_key)


func _on_area_entered(area: Area2D) -> void:
	area_active = true
	if !area_name.is_empty():
		label.visible = true


func _on_area_exited(area: Area2D) -> void:
	area_active = false
	if !area_name.is_empty():
		label.visible = false
