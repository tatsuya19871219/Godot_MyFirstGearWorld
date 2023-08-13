extends Node

@export var target: RigidBody3D
@export var property_name: String
@export var subproperty_name: String

@export var line_spec: LineSpec

@export var negate: bool = false

enum PLOT_FUNCTION {IDENTITY, SIN, UAT}
@export var plot_function: PLOT_FUNCTION

@onready var my_graph = get_parent() #$MyGraph


var plot_id: int

# Called when the node enters the scene tree for the first time.
func _ready():
	plot_id = my_graph.add_my_graph(line_spec)
	
	pass # Replace with function body.


var my_time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	my_time += delta
	
	if target == null: return
	
	var my_value = target[property_name][subproperty_name]
	if negate: my_value = -my_value
	
	match plot_function:
		PLOT_FUNCTION.IDENTITY:
			pass
		PLOT_FUNCTION.SIN:
			my_value = sin(my_value)
		PLOT_FUNCTION.UAT:
			my_value /= TAU	
	
	my_graph.add_my_point(my_time, my_value, plot_id)
	
	pass
