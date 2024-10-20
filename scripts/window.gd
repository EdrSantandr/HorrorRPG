extends Area2D
@onready var window_sound: AudioStreamPlayer2D = $window_sound
var is_player_inside:bool = false
var sound_position:float = 0.0


func _on_ready() -> void:
	window_sound.stream = Global.SOUND_ambience_rain_window
	window_sound.bus = &"SFX"


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		print("window")
		is_player_inside = true
		if sound_position > window_sound.stream.get_length():
			sound_position = 0.0
		window_sound.play(sound_position)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		print("OUT window")
		sound_position = window_sound.get_playback_position()
		window_sound.stop()
		is_player_inside = false
