# script: camera

extends Camera2D

onready var bird = Utils.get_main_node().get_node("Bird")

func _ready():
	pass
	
func _physics_process(delta):
	position = Vector2(bird.position.x, position.y)
	
func get_total_pos():
	return position + offset