extends TextureIconButton
class_name ExitBtn


func _pressed():
	._on_pressed()
	get_tree().quit()
