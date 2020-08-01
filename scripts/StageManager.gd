extends CanvasLayer

const STAGE_GAME : String = "res://stages/game_stage.tscn"
const STAGE_MENU : String = "res://stages/MainMenu.tscn"

var audio_clips : Dictionary = {
	"Die": preload("res://sounds/sfx_die.wav"),
	"Hit": preload("res://sounds/sfx_hit.wav"),
	"Point": preload("res://sounds/sfx_point.wav"),
	"Swoosh": preload("res://sounds/sfx_swooshing.wav"),
	"Flap": preload("res://sounds/sfx_wing.wav"),
}

const SIMPLE_AUDIO_PLAYER_SCENE : PackedScene = preload("res://scenes/Simple_Audio_Player.tscn")
var created_audio = []

var is_changing : bool = false

signal stage_changed
	
func change_stage(stage_path) -> void:
	if is_changing: return
	
	is_changing = true
	get_tree().get_root().gui_disable_input = true
	
	# fade to black
	self.layer = 5
	$Anim.play("fade_in")
	
	for sound in created_audio:
		if (sound != null):
			sound.queue_free()
	created_audio.clear()
	
	play_sound("Swoosh")
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
	

func play_sound(sound_name: String, loop_sound: bool =false) -> void:
	if audio_clips.has(sound_name):
		var new_audio : Node = SIMPLE_AUDIO_PLAYER_SCENE.instance()
		new_audio.should_loop = loop_sound
		
		add_child(new_audio)
		created_audio.append(new_audio)
		
		new_audio.play_sound(audio_clips[sound_name])
	else:
		print("ERROR: cannot play sound that does not exist in audio_clips!")
		
