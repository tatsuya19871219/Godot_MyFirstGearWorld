@tool

extends NestableRigidBody3D

@export var teeth_number: int

@onready var teeth_angle: float = TAU / teeth_number

# Called when the node enters the scene tree for the first time.
func _ready():
	# duplicate tooth collision
	var tooth_rigid = $"CrownGear/CrownGearTooth-rigid"
	var tooth_collision_original = $"CrownGear/CrownGearTooth-rigid/CollisionShape3D"
	
	for i in range(1, teeth_number):
		var tooth_collision_duplicate = tooth_collision_original.duplicate()
		tooth_collision_duplicate.rotation.y = teeth_angle * i
		
		tooth_rigid.add_child(tooth_collision_duplicate)
		tooth_collision_duplicate.set_owner(tooth_rigid)
		
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
