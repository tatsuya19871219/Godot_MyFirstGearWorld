class_name Mini4WD extends NestableRigidBody3D

@export var input_strength: float = 0.0:
	get:
		return input_strength
		#return gearbox.input_strength
	set(value):
		input_strength = value
		if gearbox != null: gearbox.input_strength = value

@export var switch_on: bool = false:
	get:
		return switch_on
	set(value):
		switch_on = value
		if gearbox == null: return
		if value:
			gearbox.on()
		else:
			gearbox.off()
		
@onready var gearbox:GearBox = $CarBody/GearBox

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	gearbox.input_strength = input_strength
	if switch_on: gearbox.on()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
