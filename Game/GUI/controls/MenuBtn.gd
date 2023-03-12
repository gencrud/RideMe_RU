# extends TouchScreenButton
extends "res://Game/GUI/controls/ControlBtn.gd"
class_name MenuBtn


func _on_pressed() -> void:
	$AnimationPlayer.play("rotate")


func _on_released() -> void:
	var game_menu: Control = get_node(PathData.PATH_GAME_SCREEN_PAUSE)
	game_menu.set_paused(true)
