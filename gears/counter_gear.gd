@tool

extends RigidBody3D

@export var outer_involute_gear_collision_polygon: PackedVector2Array
@export var outer_gear_mesh_size_ratio = 1.0

@export var inner_involute_gear_collision_polygon: PackedVector2Array
@export var inner_gear_mesh_size_ratio = 1.0


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
	var outer_transform2d = Transform2D.IDENTITY
	outer_transform2d = outer_transform2d.scaled(outer_gear_mesh_size_ratio * Vector2.ONE)
	$OuterCollisionPolygon3D.polygon = outer_involute_gear_collision_polygon * outer_transform2d
	
	var inner_transform2d = Transform2D.IDENTITY
	inner_transform2d = inner_transform2d.scaled(inner_gear_mesh_size_ratio * Vector2.ONE)
	$InnerCollisionPolygon3D.polygon = inner_involute_gear_collision_polygon * inner_transform2d
