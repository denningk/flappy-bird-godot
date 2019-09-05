extends StaticBody2D

onready var right : Position2D = $Right
onready var camera : Camera2D = Utils.get_main_node().get_node("Camera")

func _process(_delta):
	if camera == null: return
	
	if right.global_position.x <= camera.get_total_pos().x:
		queue_free()