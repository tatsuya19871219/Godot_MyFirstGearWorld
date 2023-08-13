@tool

class_name Motor extends NestableRigidBody3D

@export var input_strength = 0.0:
	get: 
		return input_strength
	set(value):
		input_strength = value
		if my_rotor != null:
			update_rotor_input(value)


@export var magnet_strength = 1.0: 
	get:
		return magnet_strength
	set(value):
		magnet_strength = value
		if my_magnet_n != null and my_magnet_s != null:
			update_magnet_strength(value)


@onready var my_rotor = $rotor_3coils
@onready var my_magnet_n = $N
@onready var my_magnet_s = $S

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	update_rotor_input(input_strength)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_rotor_input(value):
	my_rotor.strength = value
	pass


func update_magnet_strength(value):
	my_magnet_n.gravity = - magnet_strength
	my_magnet_s.gravity = magnet_strength

