extends Node

var audio_node : AudioStreamPlayer = null
var should_loop : bool = false
var globals = null

func _ready():
	audio_node = $AudioStreamPlayer
	audio_node.connect("finished", self, "sound_finished")
	audio_node.stop()
	
	globals = get_node("/root/StageManager")


func play_sound(audio_stream : AudioStream):
	if audio_stream == null:
		print("No audio stream passed; cannot play sound")
		globals.created_audio.remove(globals.created_audio.find(self))
		queue_free()
		return
		
	audio_node.stream = audio_stream
	audio_node.play(0.0)
	

func sound_finished():
	if should_loop:
		audio_node.play(0.0)
	else:
		globals.created_audio.remove(globals.created_audio.find(self))
		audio_node.stop()
		queue_free()
		