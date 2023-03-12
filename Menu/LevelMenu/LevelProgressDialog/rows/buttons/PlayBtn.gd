extends TextureButton
class_name PlayBtn

const audio_btn_pressed = preload("res://media/ui/btn_pressed.wav")
const audio_btn_run = preload("res://media/ui/btn_run.wav")
const audio_btn_pay = preload("res://media/ui/btn_pay.wav")
const audio_btn_error = preload("res://media/ui/btn_error.wav")

var type
var path_data: PathData = preload("res://Autoload/PathData.gd").new()


func _on_button_down():
	if "Error" == type:
		$AudioStreamPlayer2D.set_stream(audio_btn_error)
	elif "Run" == type:
		$AudioStreamPlayer2D.set_stream(audio_btn_run)
	elif "Buy" == type:
		$AudioStreamPlayer2D.set_stream(audio_btn_pay)
	else:
		$AudioStreamPlayer2D.set_stream(audio_btn_pressed)
	$AudioStreamPlayer2D.play()


func _on_pressed():
	if GameData.current_level:
		yield(get_tree().create_timer(0.4), "timeout")
		var res := get_tree().change_scene(path_data.RES_LEVEL_MENU_TSCN)
		
		if res != OK:
			printerr("ERROR: " + str(self) + " " + str(res) + "_on_pressed and change_scene")
	else:
		printerr("[warn] GameData was undefined")



