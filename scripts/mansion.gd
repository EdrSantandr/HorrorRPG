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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ambience_inside.stream = Global.SOUND_ambience_inside
	ambience_inside.bus = &"Music"
	ambience_inside.play()
	show_normal_layers(true)
	show_spooky_layers(false)


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
	if !in_show:
		floor_spooky.hide()
		object_spooky.hide()
		wall_spooky.hide()
		door_spooky.hide()


func show_normal_layers(in_show: bool):
	if in_show:
		floor_normal.show()
		object_normal.show()
		wall_normal.show()
	if !in_show:
		floor_normal.hide()
		object_normal.hide()
		wall_normal.hide()
	
