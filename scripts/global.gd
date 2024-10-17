extends Node

var player_current_attack = false

var current_scene: String = "world"
var is_transition_scene: bool = false

var player_exit_cliffside_pos: Vector2 = Vector2(0,0)
var player_start_pos: Vector2 = Vector2(17,61)

func scene_changed(body: Node2D):
	if is_transition_scene:
		is_transition_scene = false
		if current_scene == "world":
			player_exit_cliffside_pos =  body.position
			player_exit_cliffside_pos.y += 10
			current_scene = "cliff_side"
		else:
			current_scene = "world"
			player_start_pos = player_exit_cliffside_pos
