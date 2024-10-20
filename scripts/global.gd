extends Node

var player_current_attack = false

var current_scene: String = "world"
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

var is_open_door_1:bool = false
var is_open_door_2:bool = false
var is_open_door_3:bool = false

func scene_changed(body: Node2D):
	if is_transition_scene:
		is_transition_scene = false
		if current_scene == "world":
			player_exit_cliffside_pos =  body.position
			player_exit_cliffside_pos.y += 10
			current_scene = "mansion"
		else:
			current_scene = "world"
			player_start_pos = player_exit_cliffside_pos

func update_interaction_doors():
	if (is_interacted_object_1 && is_interacted_object_2 && is_interacted_object_3):
		is_open_door_1 = true
		#todo open door 1
	elif (is_interacted_object_4 && is_interacted_object_5):
		is_open_door_2 = true
		#todo open door 2
	elif (is_interacted_object_6):
		is_open_door_3 = true
		print("block_3 open")
		var world = get_tree().get_root().get_node("world")
		if world != null:
			world.remove_block("block_3")
		

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
	update_interaction_doors()
