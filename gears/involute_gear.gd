@tool

extends RigidBody3D

@export var involute_gear_collision_polygon: PackedVector2Array
@export var gear_mesh_size_ratio = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	update_collision_polygon()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		update_collision_polygon()
	pass


func update_collision_polygon():
	var transform2d = Transform2D.IDENTITY
	transform2d = transform2d.scaled(gear_mesh_size_ratio * Vector2.ONE)
	$CollisionPolygon3D.polygon = involute_gear_collision_polygon * transform2d
