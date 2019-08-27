# script: camera

extends Camera2D

onready var bird = $"../Bird"

func _ready():
	pass
	
func _physics_process(delta):
	position = Vector2(bird.position.x, position.y)