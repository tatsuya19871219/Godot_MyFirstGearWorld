class_name NestableRigidBody3D extends RigidBody3D

#@export var collision_exceptions: Array[PhysicsBody3D] = []
@export var my_collision_exceptions: Array[NodePath] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print(self)
	
	make_collision_exception(my_collision_exceptions)

	print(self, " has nested collision exceptions as ", scanned_collision_exceptions)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var scanned_collision_exceptions: Array[NodePath] = []

func make_collision_exception(exception_body_list):
	for collision_exception in exception_body_list:
		var body = get_node(collision_exception) as PhysicsBody3D
		if body == null: continue
		if body in get_collision_exceptions() and collision_exception in scanned_collision_exceptions: 
			continue
		
		print(">>> ", body)
		
		scanned_collision_exceptions.append(collision_exception)
		add_collision_exception_with(body)
		
		var nestable_body = body as NestableRigidBody3D
		if nestable_body == null: continue
		
		print("--", nestable_body)
		
		var nested_body_list: Array[NodePath] = nestable_body.my_collision_exceptions
		
		print("->", nested_body_list)
		
		if nested_body_list.size() == 0: continue
		
		var nested_collision_exception_list: Array[NodePath] = []
		for item in nested_body_list:
			var item_node_path: NodePath
			if item.is_absolute():
				item_node_path = item
			else:
				item_node_path = NodePath("%s/%s" % [nestable_body.get_path(), item])
			print(item_node_path)
			nested_collision_exception_list.append(item_node_path)
		
		print(nested_collision_exception_list)
		make_collision_exception(nested_collision_exception_list)
