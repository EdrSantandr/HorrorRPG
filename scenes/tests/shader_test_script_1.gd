extends ColorRect
@onready var show_timer: Timer = $show_timer
@onready var color_rect: ColorRect = $"."



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_show_timer_timeout() -> void:
	print("kill previous")
	queue_free()
