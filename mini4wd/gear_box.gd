class_name GearBox extends NestableRigidBody3D

@export var input_strength = -50.0

@onready var motor:Motor = $Motor

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on():
	motor.input_strength = input_strength
	pass
	
func off():
	motor.input_strength = 0.0
	pass
