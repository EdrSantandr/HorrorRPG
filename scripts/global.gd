extends Node

# Variables for object sounds
const SOUND_LOOP_unlock_door = preload("res://assets/sounds/loop/LOOP_unlock_door.wav")

# Variables for ambience sounds
const SOUND_ambience_outside = preload("res://assets/sounds/ambience/SFX_Ambience_Outside.ogg")
const SOUND_ambience_inside = preload("res://assets/sounds/ambience/SFX_Ambience_Inside.ogg")
const SOUND_ambience_rain_window = preload("res://assets/sounds/ambience/SFX_Ambience_Rain_Window.ogg")

# Variables for object sounds
const SOUND_object_a = preload("res://assets/sounds/sfx/SFX_ObjectA_AttendanceBook.ogg")
const SOUND_object_b = preload("res://assets/sounds/sfx/SFX_ObjectB_Knife.ogg")
const SOUND_object_c = preload("res://assets/sounds/sfx/SFX_ObjectC_Photo.ogg")
const SOUND_object_d = preload("res://assets/sounds/sfx/SFX_ObjectD_DollPapa.ogg")
const SOUND_object_e = preload("res://assets/sounds/sfx/SFX_ObjectE_Flowers.ogg")
const SOUND_object_f = preload("res://assets/sounds/sfx/SFX_Object_ChestOpen.ogg")
const SOUND_door = preload("res://assets/sounds/sfx/SFX_Object_Door.ogg")

var player_ref: CharacterBody2D = null 

var player_current_attack = false

var current_scene: String = "outside"
var is_transition_scene: bool = false

var player_exit_cliffside_pos: Vector2 = Vector2(0,0)
var player_start_pos: Vector2 = Vector2(17,61)

var is_interacted_object_1: bool = false
var is_interacted_object_2: bool = false
var is_interacted_object_3: bool = false
var is_interacted_object_4: bool = false
var is_interacted_object_5: bool = false
var is_interacted_object_6: bool = false
var is_interacted_object_7: bool = false

var is_interacted_object_final_aa: bool = false
var is_interacted_object_final_cc: bool = false

var is_open_door_1:bool = false
var is_open_door_2:bool = false
var is_open_door_3:bool = false

func scene_changed(body: Node2D):
	if is_transition_scene:
		is_transition_scene = false
		if current_scene == "outside":
			player_exit_cliffside_pos =  body.position
			player_exit_cliffside_pos.y += 10
			current_scene = "mansion"
		else:
			current_scene = "outside"
			player_start_pos = player_exit_cliffside_pos

func update_interaction_doors():
	var mansion = get_tree().get_root().get_node("mansion")
	if (is_interacted_object_1 && is_interacted_object_2 && !is_open_door_1):
		is_open_door_1 = true
		print("block_1 open")
		if mansion != null:
			mansion.remove_block("block_1")
	elif (is_interacted_object_3 && is_interacted_object_4 && !is_open_door_2):
		is_open_door_2 = true
		print("block_2 open")
		if mansion != null:
			mansion.remove_block("block_2")
	elif (is_interacted_object_5 && is_interacted_object_6 && !is_open_door_3):
		is_open_door_3 = true
		print("block_3 open")
		if mansion != null:
			mansion.remove_block("block_3")
	elif (is_interacted_object_final_aa && is_interacted_object_final_cc):
		if player_ref != null:
			is_transition_scene = true
			player_ref.show_shader_initial()


func update_interaction_objects(object_name:String):
	match object_name:
		"object_a":
			is_interacted_object_1 = true
		"object_b":
			is_interacted_object_2 = true
		"object_c":
			is_interacted_object_3 = true
		"object_d":
			is_interacted_object_4 = true
		"object_e":
			is_interacted_object_5 = true
		"object_f":
			is_interacted_object_6 = true
		"object_g":
			is_interacted_object_7 = true
		"object_aa":
			is_interacted_object_final_aa = true
		"object_cc":
			is_interacted_object_final_cc = true
	update_interaction_doors()
