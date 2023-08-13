extends CheckButton

@export var my_probe: RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	my_probe.disable()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_toggled(button_pressed):
	if button_pressed:
		my_probe.enable()
		text = "On"
	else:
		my_probe.disable()
		text = "Off"
	pass # Replace with function body.
