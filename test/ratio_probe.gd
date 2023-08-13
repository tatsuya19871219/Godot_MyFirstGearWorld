extends Node

@export var numerator_target: RigidBody3D
@export var numerator_property_name: String
@export var numerator_subproperty_name: String

@export var denominator_target: RigidBody3D
@export var denominator_property_name: String
@export var denominator_subproperty_name: String

@export var line_spec: LineSpec

@export var negate: bool = false

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
	
	if numerator_target == null: return
	
	var my_numerator_value = numerator_target[numerator_property_name][numerator_subproperty_name]
	var my_denominator_value = denominator_target[denominator_property_name][denominator_subproperty_name]
	
	var my_ratio = my_numerator_value / my_denominator_value
	if negate: my_ratio = -my_ratio
	
	my_graph.add_my_point(my_time, my_ratio, plot_id)
	
	pass
