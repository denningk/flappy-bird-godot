# script: camera

extends Camera2D

onready var bird = get_tree().get_root().get_child(0).get_node("Bird")

func _ready():
	pass
	
func _physics_process(delta):
	position = Vector2(bird.position.x, position.y)