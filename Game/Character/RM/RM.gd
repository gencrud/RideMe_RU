extends BonusArea
class_name RM


func _ready() -> void:
	set_physics_process(false)
	set_process(false)
	# visible = false
	# get_parent().remove_child(self)


func _on_body_entered(body: Player) -> void:
	._on_body_entered(body)
	
	if is_instance_valid(body) and body.name == "Player":
		rm_counter_do_anim_success()
		PlayerData.rms += 1


func _on_body_exited(body) -> void:
	._on_body_exited(body)


func rm_counter_do_anim_success() -> void:
	var _anim_player: AnimationPlayer = get_node(PathData.PATH_RMS_COUNTER + '/AnimationPlayer')
	if _anim_player.current_animation != PlayerData.ANIMATION_SUCCESS:
		_anim_player.play(PlayerData.ANIMATION_SUCCESS)


func _on_VisibilityEnabler_screen_exited() -> void:
	._on_VisibilityNotifier_screen_exited()


func _on_VisibilityEnabler_screen_entered() -> void:
	visible = true
