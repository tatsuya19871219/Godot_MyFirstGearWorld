extends RigidBody3D

@export var parent_toque_meter: Node2D
@export var probing_speed = 1.0

@export var probe_torque_delta_max = 1.0

var probed_values: Array[float] = []

var current_torque: float

# Called when the node enters the scene tree for the first time.
func _ready():
	current_torque = 0.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parent_toque_meter.set_current_read(-current_torque)
	pass


func enable():
	$HingeJoint3D["angular_limit/enable"] = true
	
func disable():
	$HingeJoint3D["angular_limit/enable"] = false


func _on_probe_timer_timeout():
	
	var last_torque = current_torque
	
	probed_values.append(last_torque)
	
	var rotation_speed = angular_velocity.z
	
	var average_value = probed_values.reduce(sum) / probed_values.size()
	
	current_torque = average_value - rotation_speed * probing_speed
	
	set_deferred("constant_torque", Vector3(0, 0, current_torque))


func sum(accum, number):
	return accum + number
