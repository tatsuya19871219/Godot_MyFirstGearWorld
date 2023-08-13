@tool

extends Node2D

@export var background_color = Color.BLACK

@export var history_size = -1

@export var label_x = "Value 1"
@export var label_y = "Value 2"

@export var default_plot_color = Color.YELLOW
@export var default_dot_radius = 1.0

@export var x_range = Vector2(-20.0, 20.0)
@export var y_range = Vector2(-20.0, 20.0)

@export var origin_position = GraphGrid.ORIGIN_POSITION.CENTER

@onready var grid = $GraphGrid
var offset_x: float
var offset_y: float

# pixels per value
var px_per_val_x: float = 1.0
var px_per_val_y: float = 1.0

var graphs: Array[GraphCanvas] = []
var dot_specs: Array[DotSpec] = []

var label_formatter = "%3.1f"


# Called when the node enters the scene tree for the first time.
func _ready():

	grid.origin_position = origin_position
	
	offset_x = grid.position.x
	offset_y = grid.position.y
	
	grid.position = Vector2(offset_x, offset_y)
	
	var x_max = x_range[1]
	var x_min = x_range[0]
	var y_max = y_range[1]
	var y_min = y_range[0]
	
	px_per_val_x = grid.width / (x_max - x_min) 
	px_per_val_y = grid.height / (y_max - y_min)

	update_coordination_x(x_min, x_max)
	update_coordination_y(y_min, y_max)

	$XLabel.text = label_x
	$YLabel.text = label_y

	if Engine.is_editor_hint(): return
	
	#add_my_graph()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_my_graph(dot_spec: DotSpec = null) -> int: # return plot_id
	var my_graph := GraphCanvas.new()
	
	if dot_spec == null:
		dot_spec = DotSpec.new()
		dot_spec.color = default_plot_color
		dot_spec.radius = default_dot_radius
	
	my_graph.default_color = dot_spec.color
	my_graph.default_radius = dot_spec.radius
	dot_specs.append(dot_spec)
	
	graphs.append(my_graph)
	
	add_child.call_deferred(my_graph)
	my_graph.set_owner(self)
	
	return graphs.size()-1

func add_my_point(x: float, y: float, plot_id:int = 0):
	
	if plot_id == 0 and graphs.size() == 0:
		add_my_graph()
	
	var x_max = x_range[1]
	var x_min = x_range[0]
	var y_max = y_range[1]
	var y_min = y_range[0]
	
	var normalized_x = (x - x_min) / (x_max - x_min)
	
	var plot_x = normalized_x * grid.width + offset_x
	
	var normalized_y = (y - y_min) / (y_max - y_min)
	
	var plot_y = (1 - normalized_y) * grid.height + offset_y
	
	if (history_size >= 0 and graphs[plot_id].points.size() > history_size):
		while graphs[plot_id].points.size() > history_size:
			graphs[plot_id].points.pop_front()
	
	graphs[plot_id].push_point(Vector2(plot_x, plot_y))
	pass


func update_coordination_x(x_min, x_max):
	match(origin_position):
		GraphGrid.ORIGIN_POSITION.CENTER:
			$MinXValue.text = label_formatter % x_min
			$CenterXValue.text = label_formatter % 0
			$MaxXValue.text = label_formatter % x_max
			if (-x_min == x_max): push_warning("abs(x_min) == x_max is required for CENTER Alignment")
			
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
			if (y_min != 0): push_warning("y_min should be 0 for BOTTOM Alignment")
			

