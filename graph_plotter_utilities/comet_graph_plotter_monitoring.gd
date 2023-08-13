extends Node

@export var x_target: RigidBody3D
@export var x_property_name: String
@export var x_subproperty_name: String

@export var y_target: RigidBody3D
@export var y_property_name: String
@export var y_subproperty_name: String

enum PLOT_FUNCTION {IDENTITY, SIN}
@export var plot_function: PLOT_FUNCTION

@export var dot_spec: DotSpec

@onready var my_graph = get_parent() #$MyGraph

var plot_id: int

# Called when the node enters the scene tree for the first time.
func _ready():
	plot_id = my_graph.add_my_graph(dot_spec)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if x_target == null: return
	
	var my_x_property = x_target[x_property_name]
	var my_x_subproperty = my_x_property[x_subproperty_name]
	var my_x_value = my_x_subproperty
	
	var my_y_property = y_target[y_property_name]
	var my_y_subproperty = my_y_property[y_subproperty_name]
	var my_y_value = my_y_subproperty
	
	match plot_function:
		PLOT_FUNCTION.IDENTITY:
			pass
		PLOT_FUNCTION.SIN:
			my_x_value = sin(my_x_value)
			my_y_value = sin(my_y_value)
	
	
	my_graph.add_my_point(my_x_value, my_y_value, plot_id)
	
	pass
