extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func remove_block(name: String):
	var block_child = find_child(name)
	if block_child != null:
		block_child.open_block()
