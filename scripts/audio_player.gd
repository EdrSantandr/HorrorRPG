extends AudioStreamPlayer2D

const outside_level_music = preload("res://assets/sounds/ambience/SFX_Ambience_Outside.ogg")
const inside_level_music = preload("res://assets/sounds/ambience/SFX_Ambience_Inside.ogg")

func _play_music(music: AudioStream, volume=-2.0):
	bus = &"Music"
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()


func play_music_level():
	if Global.current_scene == "outside":
		_play_music(outside_level_music)
	elif Global.current_scene == "mansion":
		_play_music(inside_level_music)
