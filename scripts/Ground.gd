# script: Ground

extends StaticBody2D

onready var bottom_right = $Bottom_right
onready var camera = Utils.get_main_node().get_node("Camera")

func _ready():
	add_to_group(Game.GROUP_GROUNDS)

func _process(_delta):
	if camera == null: return
	
	if bottom_right.global_position.x <= camera.get_total_pos().x:
		queue_free()