extends Area2D
@onready var window_sound: AudioStreamPlayer2D = $window_sound
var is_player_inside:bool = false
var sound_position:float = 0.0
var percentage_volume:float = 0.0
var player_body: Node2D = null

var max_volume:float = 80.0
var volume_attenuation:float = 0.5

func _process(delta: float) -> void:
	if is_player_inside && player_body!=null:
		var distance:float = (self.position - player_body.position).length()
		percentage_volume = (max_volume - distance)/max_volume;
		percentage_volume = max(0.0, percentage_volume)
		percentage_volume *= volume_attenuation
		window_sound.volume_db = linear_to_db(percentage_volume)

func _on_ready() -> void:
	window_sound.stream = Global.SOUND_ambience_rain_window
	window_sound.bus = &"SFX"


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		is_player_inside = true
		player_body = body
		if sound_position > window_sound.stream.get_length():
			sound_position = 0.0
		window_sound.play(sound_position)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		sound_position = window_sound.get_playback_position()
		window_sound.stop()
		is_player_inside = false
		player_body = null
