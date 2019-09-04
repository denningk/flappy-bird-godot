extends StaticBody2D

onready var right : Position2D = $Right
onready var camera : Camera2D = Utils.get_main_node().get_node("Camera")

func _process(_delta):
	if right.global_position.x:
		pass