extends Node2D
@onready var ambience_inside: AudioStreamPlayer2D = $ambience_inside
@onready var player: CharacterBody2D = $player

@onready var floor_normal: TileMapLayer = $floor_normal
@onready var object_normal: TileMapLayer = $object_normal
@onready var wall_normal: TileMapLayer = $wall_normal

@onready var floor_spooky: TileMapLayer = $floor_spooky
@onready var object_spooky: TileMapLayer = $object_spooky
@onready var wall_spooky: TileMapLayer = $wall_spooky
@onready var door_spooky: TileMapLayer = $door_spooky

var time_steady:float = 1.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ambience_inside.stream = Global.SOUND_ambience_inside
	ambience_inside.bus = &"Music"
	ambience_inside.play()
	show_normal_layers(true)
	show_spooky_layers(false)

func _process(delta: float) -> void:
	if Global.is_showing_spooky_layers:
		Global.spooking_time += delta
		if (Global.spooking_time > time_steady):
			var sine_value = sin(Global.spooking_time)
			sine_value = abs(sine_value)
			var rand_show_floor:float = randf_range(0.0, 1.0)
			var rand_show_object:float = randf_range(0.0, 1.0)
			var rand_show_wall:float = randf_range(0.0, 1.0)
			
			var show_hide_floor:bool = rand_show_floor < rand_show_object
			var show_hide_object:bool = rand_show_object < rand_show_wall
			var show_hide_wall:bool = rand_show_wall < rand_show_floor
			
			if rand_show_floor < sine_value:
				var layer_floor: TileMapLayer = [floor_normal,floor_spooky].pick_random()
				if show_hide_floor:
					layer_floor.show()
				else:
					layer_floor.hide()
					
			if rand_show_object < sine_value:
				var layer_object: TileMapLayer = [object_normal,object_spooky].pick_random()
				if show_hide_object:
					layer_object.show()
				else:
					layer_object.hide()
				
			if rand_show_wall < sine_value:
				var layer_wall: TileMapLayer = [wall_normal,wall_spooky,door_spooky].pick_random()
				if show_hide_wall:
					layer_wall.show()
				else:
					layer_wall.hide()


func remove_block(name: String):
	var block_child = find_child(name)
	if block_child != null:
		block_child.open_block()
		if player != null:
			player.show_shader_initial()


func show_spooky_layers(in_show: bool):
	if in_show:
		floor_spooky.show()
		object_spooky.show()
		wall_spooky.show()
		door_spooky.hide()
		Global.is_showing_spooky_layers = true
		Global.spooking_time = 0.0
	if !in_show:
		floor_spooky.hide()
		object_spooky.hide()
		wall_spooky.hide()
		door_spooky.hide()
		Global.is_showing_spooky_layers = false
		Global.spooking_time = 0.0


func show_normal_layers(in_show: bool):
	if in_show:
		floor_normal.show()
		object_normal.show()
		wall_normal.show()
	if !in_show:
		floor_normal.hide()
		object_normal.hide()
		wall_normal.hide()
