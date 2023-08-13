@tool

extends Node3D

var _my_global_position: Vector3

@export var my_global_position: Vector3:
	get:
		return _my_global_position
	set(value):
		print("This is read-only")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		if my_global_position != global_position:
			_my_global_position = global_position
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
