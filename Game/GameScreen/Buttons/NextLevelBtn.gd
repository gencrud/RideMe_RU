extends TextureIconButton
class_name NextLevelBtn


func _pressed():
	._on_pressed()
	get_tree().paused = false
