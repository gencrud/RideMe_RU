extends Button
class_name Current


const audio_btn_pressed = preload("res://media/ui/btn_pressed.wav")
const audio_btn_error = preload("res://media/ui/btn_error.wav")


func _on_button_down():
	if flat or disabled:
		$AudioStreamPlayer2D.set_stream(audio_btn_error)
	else:
		$AudioStreamPlayer2D.set_stream(audio_btn_pressed)
	$AudioStreamPlayer2D.play()
