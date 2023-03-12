extends TextureIconButton
class_name ContinueGameBtn

onready var game_menu: Control = get_node(PathData.PATH_GAME_SCREEN_PAUSE)


func _pressed():
	._on_pressed()
	game_menu.set_paused(false)
