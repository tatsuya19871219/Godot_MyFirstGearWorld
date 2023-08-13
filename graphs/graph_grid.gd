@tool

class_name GraphGrid extends Node2D

@export_range(10.0, 1000.0) var width = 50.0
@export_range(10.0, 1000.0) var height = 50.0

@export var line_color := Color.WHITE

@export_range(0.1, 10.0) var line_width_major := 2.0
@export_range(0.1, 10.0) var line_width_minor := 1.0

@export_range(2, 100) var horizontal_grids := 10
@export_range(2, 100) var vertical_grids := 10

@export_range(1, 99) var major_interval := 5

enum ORIGIN_POSITION {CENTER, LEFT_BOTTOM, LEFT_CENTER}

@export var origin_position: ORIGIN_POSITION:
	get:
		return origin_position
	set(value):
		origin_position = value
		if Engine.is_editor_hint(): make_grid()

# Called when the node enters the scene tree for the first time.
func _ready():
	make_grid()
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if Engine.is_editor_hint():
#		make_grid()
	pass


func make_grid():
	
	# clear current grid
	for child in get_children():
		remove_child(child)
		
	var horizontals: Array[Line2D] = []
	var verticals: Array[Line2D] = []
	
	var dx = width / horizontal_grids
	var dy = height / vertical_grids
	
	var dl = line_width_major / 2
	
	for i in range(horizontal_grids+1):
		var line = Line2D.new()
		line.add_point(Vector2(dx*i, 0 - dl))
		line.add_point(Vector2(dx*i, height + dl))
		line.width = line_width_minor
		line.default_color = line_color
		
		horizontals.append(line)
		add_child(line)
		line.set_owner(self)
		
	for j in range(vertical_grids+1):
		var line = Line2D.new()
		line.add_point(Vector2(0 - dl, dy*j))
		line.add_point(Vector2(width + dl, dy*j))
		line.width = line_width_minor
		line.default_color = line_color
		
		verticals.append(line)
		add_child(line)
		line.set_owner(self)
	
	# set major grids
	match(origin_position):
		ORIGIN_POSITION.CENTER:
			# *_grids should be even numbers to show origin correctly
			var i_origin = horizontal_grids/2
			for i in range(0, i_origin+1, major_interval):
				if i == 0:
					horizontals[i_origin].width = line_width_major
				else:
					horizontals[i_origin+i].width = line_width_major
					horizontals[i_origin-i].width = line_width_major
		
			var j_origin = vertical_grids/2
			for j in range(0, j_origin+1, major_interval):
				if j == 0:
					verticals[j_origin].width = line_width_major
				else:
					verticals[j_origin+j].width = line_width_major
					verticals[j_origin-j].width = line_width_major
		
		ORIGIN_POSITION.LEFT_BOTTOM:
			var i_origin = 0
			for i in range(0, horizontal_grids+1, major_interval):
				horizontals[i_origin+i].width = line_width_major
				
			var j_origin = vertical_grids
			for j in range(0, vertical_grids+1, major_interval):
				verticals[j_origin-j].width = line_width_major
				
		ORIGIN_POSITION.LEFT_CENTER:
			var i_origin = 0
			for i in range(0, horizontal_grids+1, major_interval):
				horizontals[i_origin+i].width = line_width_major
				
			var j_origin = vertical_grids/2
			for j in range(0, j_origin+1, major_interval):
				if j == 0:
					verticals[j_origin].width = line_width_major
				else:
					verticals[j_origin+j].width = line_width_major
					verticals[j_origin-j].width = line_width_major
	
	pass
