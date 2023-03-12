extends TextureIconButton
class_name MainMenuBtn


func _pressed():
	._on_pressed()
	get_tree().paused = false
