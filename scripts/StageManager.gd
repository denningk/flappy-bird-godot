extends CanvasLayer

const STAGE_GAME : String = "res://stages/game_stage.tscn"

var is_changing : bool = false

signal stage_changed
	
func change_stage(stage_path) -> void:
	if is_changing: return
	
	is_changing = true
	get_tree().get_root().gui_disable_input = true
	
	# fade to black
	self.layer = 5
	$Anim.play("fade_in")
	yield($Anim, "animation_finished")
	
	# change stage
	get_tree().change_scene(stage_path)
	emit_signal("stage_changed")
	
	# fade from black
	$Anim.play("fade_out")
	yield($Anim, "animation_finished")
	
	self.layer = 1
	self.is_changing = false
	get_tree().get_root().gui_disable_input = false