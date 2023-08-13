@tool

extends Node2D

@export var background_color = Color.BLACK

@export var label_y = "Value"
@export var default_plot_color = Color.YELLOW
@export var default_plot_width = 2.0

#@export var line_specs: Array[LineSpec] = []

@export var time_max = 10.0
@export var time_min = 0.0

@export var value_max = 20.0
@export var value_min = -20.0

@export var origin_position = GraphGrid.ORIGIN_POSITION.CENTER

@onready var grid = $GraphGrid
var offset_x: float
var offset_y: float

# pixels per value
var px_per_val_x: float = 1.0
var px_per_val_y: float = 1.0

var graphs: Array[Line2D] = []
var line_specs: Array[LineSpec] = []

var label_formatter = "%3.1f"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	grid.origin_position = origin_position
	
	offset_x = grid.position.x
	offset_y = grid.position.y
	
	grid.position = Vector2(offset_x, offset_y)
	
	px_per_val_x = grid.width / (time_max - time_min) 
	px_per_val_y = grid.height / (value_max - value_min)

	update_coordination_x(time_min, time_max)
	update_coordination_y(value_min, value_max)
	
	$YLabel.text = label_y
	
	if Engine.is_editor_hint(): return
	
	#add_my_graph()
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_my_graph(line_spec: LineSpec = null) -> int: # returns id
	
	var my_graph = Line2D.new()
	
	if line_spec == null:
		line_spec = LineSpec.new()
		line_spec.color = default_plot_color
		line_spec.width = default_plot_width
		
	my_graph.default_color = line_spec.color
	my_graph.width = line_spec.width
	line_specs.append(line_spec)
	
	my_graph.points = []
	graphs.append(my_graph)
	
	add_child.call_deferred(my_graph)
	my_graph.set_owner(self)
	
	return graphs.size()-1
	
	
var t_offset = 0.0


func add_my_point(t: float, value: float, id: int = 0):
	
		
	var plot_x = t * px_per_val_x + offset_x
	
	if plot_x > grid.width:
		t_offset = plot_x - grid.width
#		if graphs[0].points[0].x < t_offset:
#			graphs[0].remove_point(0)
		graphs[id].remove_point(0)
		
		update_coordination_x(t_offset, t_offset + time_max - time_min)

	var normalized_value = (value - value_min) / (value_max - value_min)
	
	var plot_y = (1 - normalized_value) * grid.height + offset_y
	
	
	graphs[id].add_point(Vector2(plot_x, plot_y))
	graphs[id].position.x = - t_offset
	


func update_coordination_x(x_min, x_max):
	match(origin_position):
		GraphGrid.ORIGIN_POSITION.CENTER:
			$MinXValue.text = label_formatter % x_min
			$CenterXValue.text = label_formatter % 0
			$MaxXValue.text = label_formatter % x_max
			if (-x_min == x_max): push_warning("abs(time_min) == time_max is required for CENTER Alignment")
			
		GraphGrid.ORIGIN_POSITION.LEFT_BOTTOM, GraphGrid.ORIGIN_POSITION.LEFT_CENTER:
			var x_center = (x_max+x_min)/2
			$MinXValue.text = label_formatter % x_min
			$CenterXValue.text = label_formatter % x_center
			$MaxXValue.text = label_formatter % x_max 
	

func update_coordination_y(y_min, y_max):
	match(origin_position):
		GraphGrid.ORIGIN_POSITION.CENTER, GraphGrid.ORIGIN_POSITION.LEFT_CENTER:
			$MinYValue.text = label_formatter % y_min
			$CenterYValue.text = label_formatter % 0
			$MaxYValue.text = label_formatter % y_max 
			
		GraphGrid.ORIGIN_POSITION.LEFT_BOTTOM:
			var y_center = (y_max+y_min)/2
			$MinYValue.text = label_formatter % 0 # %d" % value_min
			$CenterYValue.text = label_formatter % y_center
			$MaxYValue.text = label_formatter % y_max
			if (y_min != 0): push_warning("value_min should be 0 for BOTTOM Alignment")
			

