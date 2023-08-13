extends Node

@onready var mini4wd = $Mini4WD

func _ready():
	start_with_delay()
	pass
	
func _process(delta):
	pass


func start_with_delay():
	await get_tree().create_timer(5.0).timeout
	mini4wd.switch_on = true
