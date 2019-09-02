# script: spawner_pipe

extends Node2D

const scn_pipe = preload("res://scenes/Pipe.tscn")
const GROUND_HEIGHT = 56
const PIPE_WIDTH = 26
const OFFSET_Y = 55

func _ready():
	pass

func go_init_pos():
	randomize()
	var init_pos = Vector2()
	init_pos.x = get_viewport_rect().size.x + PIPE_WIDTH/2
	init_pos.y = rand_range(0+OFFSET_Y, get_viewport_rect().size.y - GROUND_HEIGHT - OFFSET_Y)
	position = init_pos

func spawn_pipe():
	var new_pipe = scn_pipe.instance()
	new_pipe.position = position
	$Container.add_child(new_pipe)

func go_next_pos():
	pass