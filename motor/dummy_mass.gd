class_name DummyMass extends RigidBody3D

var my_material: StandardMaterial3D


# Called when the node enters the scene tree for the first time.
func _ready():
	my_material = StandardMaterial3D.new()
	$MeshInstance3D.material_override = my_material
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_magnetic_reaction_strength(value):
	#gravity_scale = value
	#print(gravity_scale, " -> ", value)
	set_deferred("gravity_scale", value)
	show_color(value)


func show_color(value):
	if value == 0: return
	
	if  value < 0:
		my_material.albedo_color = Color.BLUE
	else:
		my_material.albedo_color = Color.RED
