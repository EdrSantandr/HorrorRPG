extends Node2D
@onready var ambience_inside: AudioStreamPlayer2D = $ambience_inside


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ambience_inside.stream = Global.SOUND_ambience_inside
	ambience_inside.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func remove_block(name: String):
	var block_child = find_child(name)
	if block_child != null:
		block_child.open_block()
