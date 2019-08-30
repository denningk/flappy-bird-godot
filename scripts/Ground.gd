# script: Ground

extends StaticBody2D

onready var bottom_right = $Bottom_right
onready var camera = Utils.get_main_node().get_node("Camera")

signal destroyed

func _ready():
	pass # Replace with function body.

func _process(delta):
	if camera == null: return
	
	if bottom_right.global_position.x <= camera.get_total_pos().x:
		queue_free()
		emit_signal("destroyed")