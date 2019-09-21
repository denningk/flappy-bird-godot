extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_enter")
	
func _on_body_enter(other_body):
	if other_body.is_in_group(Game.GROUP_BIRDS):
		Game.score_current += 1
		StageManager.play_sound("Point")
