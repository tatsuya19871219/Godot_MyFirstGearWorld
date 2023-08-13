@tool

extends RigidBody3D

@export var strength: float:
	get:
		return strength
	set(value):
		strength = value
		if not Engine.is_editor_hint():
			update_strength()
		

@export var dummy_mass_position_ratio = 0.5: 
	get:
		return dummy_mass_position_ratio
	set(value):
		if Engine.is_editor_hint():
			dummy_mass_position_ratio = value
			update_dummy_mass_position()
		else:
			print("Dynamic assignment of the dummy_mass_position_ratio is not supported.")	

@onready var dummy_mass_1: DummyMass = $DummyMass1
@onready var dummy_mass_2: DummyMass = $DummyMass2
@onready var dummy_mass_3: DummyMass = $DummyMass3

@onready var dummy_mass_joint_1 = $HingeJoint3D1
@onready var dummy_mass_joint_2 = $HingeJoint3D2
@onready var dummy_mass_joint_3 = $HingeJoint3D3

const dummy_mass_distance_min = 0.0
const dummy_mass_distance_max = 1.0

const rotation_degree_offset_1 = 90 # of Dummy Mass 1
const rotation_degree_offset_2 = -150
const rotation_degree_offset_3 = -30

class Coil:
	var current_phase: int
	var dummy_mass: DummyMass
	var rotation_degree_offset: float

var coils: Array[Coil] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var coil1 = Coil.new()
	coil1.current_phase = 0
	coil1.dummy_mass = dummy_mass_1
	coil1.rotation_degree_offset = rotation_degree_offset_1
	coils.append(coil1)
	
	var coil2 = Coil.new()
	coil2.current_phase = 1
	coil2.dummy_mass = dummy_mass_2
	coil2.rotation_degree_offset = rotation_degree_offset_2
	coils.append(coil2)
	
	var coil3 = Coil.new()
	coil3.current_phase = 1
	coil3.dummy_mass = dummy_mass_3
	coil3.rotation_degree_offset = rotation_degree_offset_3
	coils.append(coil3)
	
	update_dummy_mass_position()
	if not Engine.is_editor_hint(): update_strength()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for coil in coils:
		var current_rotation_degree = rotation_degrees.z + coil.rotation_degree_offset
		if current_rotation_degree > 180: current_rotation_degree -= 360
		if current_rotation_degree < -180: current_rotation_degree += 360
	
		match coil.current_phase:
			0:
				if current_rotation_degree < 0:
					coil.current_phase = 1
					coil.dummy_mass.set_magnetic_reaction_strength(strength)
				pass
			1:
				if current_rotation_degree > 0:
					coil.current_phase = 0
					coil.dummy_mass.set_magnetic_reaction_strength(-strength)
				pass
	pass


func update_strength():
	
	for coil in coils:
	
		var dummy_mass = coil.dummy_mass as DummyMass
		
		match coil.current_phase:
			0:
				dummy_mass.set_magnetic_reaction_strength(-strength)
				pass
			1:
				dummy_mass.set_magnetic_reaction_strength(strength)
				pass
	pass


func update_dummy_mass_position():
	var r = (dummy_mass_distance_max - dummy_mass_distance_min) * dummy_mass_position_ratio + dummy_mass_distance_min

	var position_1 = Vector3()
	position_1.x = r * cos(deg_to_rad(rotation_degree_offset_1))
	position_1.y = r * sin(deg_to_rad(rotation_degree_offset_1))
	dummy_mass_1.position = position_1
	dummy_mass_joint_1.position = position_1
	
	dummy_mass_2.position.x = r * cos(deg_to_rad(rotation_degree_offset_2))
	dummy_mass_2.position.y = r * sin(deg_to_rad(rotation_degree_offset_2))
	dummy_mass_joint_2.position = dummy_mass_2.position
	
	dummy_mass_3.position.x = r * cos(deg_to_rad(rotation_degree_offset_3))
	dummy_mass_3.position.y = r * sin(deg_to_rad(rotation_degree_offset_3))
	dummy_mass_joint_3.position = dummy_mass_3.position
