class_name GraphCanvas extends Node2D

@export var default_radius = 1.0
@export var default_color = Color.YELLOW
var points: Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	pass


func _draw():
	
	for p in points:
		draw_circle(p, default_radius, default_color)
	
	pass
	

func push_point(p: Vector2):
	points.push_back(p)
