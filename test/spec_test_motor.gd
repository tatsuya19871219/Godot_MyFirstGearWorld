extends Node


func _on_h_slider_value_changed(value):
	$Motor.input_strength = value
	#print(value)
	pass # Replace with function body.
