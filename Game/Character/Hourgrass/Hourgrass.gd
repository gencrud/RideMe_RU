extends BonusArea
class_name Hourgrass


func _on_body_entered(body: Player) -> void:
	._on_body_entered(body)
	
	if is_instance_valid(body) and body.name == "Player":
		timeout_do_anim_success()
		set_value_of_time_level()
		var res := PlayerData.set_time_level_count(body)
		assert(res != OK, "ERROR: Hourgrass _on_body_entered set_time_level_count")


func _on_body_exited(body: Player):
	._on_body_exited(body)
	

func _on_VisibilityNotifier_screen_exited() -> void:
	._on_VisibilityNotifier_screen_exited()


func timeout_do_anim_success() -> void:
	var timeout_animation: AnimationPlayer = get_node(PathData.PATH_TIMEOUT + "/AnimationPlayer")
	if timeout_animation.current_animation != PlayerData.ANIMATION_SUCCESS:
		timeout_animation.play(PlayerData.ANIMATION_SUCCESS)


func get_value_of_time_level() -> int:
	if GameData.current_track:
		return GameData.current_track.init_time_level
	return -1


func set_value_of_time_level() -> void:
	var value_of_time_level = get_value_of_time_level()
	PlayerData.time_level += value_of_time_level
