extends Area2D
@onready var chest_light: PointLight2D = $chest_light


func _on_light_timer_timeout() -> void:
	chest_light.energy = randf_range(0.5,2)
