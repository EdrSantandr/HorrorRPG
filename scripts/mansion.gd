extends Node2D
@onready var ambience_inside: AudioStreamPlayer2D = $ambience_inside
@onready var player: CharacterBody2D = $player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ambience_inside.stream = Global.SOUND_ambience_inside
	ambience_inside.bus = &"Music"
	ambience_inside.play()
	
func remove_block(name: String):
	var block_child = find_child(name)
	if block_child != null:
		block_child.open_block()
		if player != null:
			player.show_shader_initial()
