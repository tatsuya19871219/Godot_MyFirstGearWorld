extends HSlider

@onready var my_label = $Label
@onready var my_rear_axle = get_node("../../Axes/RearAxis")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_value_changed(value):
	my_label.text = "Rear axle torque: %2.1f" % value
	my_rear_axle.constant_torque = Vector3(0, 0, value)


func _on_button_pressed():
	#my_label.text = "Rear axle torque"
	#my_rear_axle.constant_torque = Vector3()
	value = 0
