extends Node2D

var current_read: float

var deg_par_value: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	current_read = 0.0
	set_read_label()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_needle()
	set_read_label()
	pass


func set_current_read(value):
	current_read = value
	pass


func set_needle():
	
	$Needle.rotation_degrees = current_read * deg_par_value
	
	pass

	
func set_read_label():
	
	var rounded_value = roundf(current_read * 100) / 100
	
	$ReadLabel.text = "%3.2f" % rounded_value
