extends HBoxContainer
class_name Bar

onready var player: KinematicBody2D = get_node(PathData.PATH_PLAYER)


func do_or_stop_animation_danger(value, max_value):
	if value < max_value / 4:
		$AnimationPlayer.play(PlayerData.ANIMATION_DANGER)
	else:
		modulate = Color(1, 1, 1, 1)
		$AnimationPlayer.stop()
