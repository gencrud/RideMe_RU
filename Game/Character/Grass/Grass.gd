extends BaseArea2D
class_name Grass

# var is_into: bool = false
# var player: Player = null


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# is_into = true
		$Particles2D.emitting = true
		body = body as Player
		
		._on_body_entered(body)
		
		if body._velocity.x > body.max_speed / 2:
			body._velocity.x = body.max_speed / 2
		# else:
		# 	body._velocity.x = body._velocity.x / 2	
		
		if body.power > body.max_power / 2:
			body.power = body.max_power / 2
		else:
			body.power = body.power / 2
		
		if PlayerData.lives + 20 > PlayerBikeCfg.DEFAULT_VALUE_LIVES:
			PlayerData.lives = PlayerBikeCfg.DEFAULT_VALUE_LIVES
		else:
			PlayerData.lives += 20

		if body.anim_player.current_animation != PlayerData.ANIMATION_SUCCESS:
			body.anim_player.play(PlayerData.ANIMATION_SUCCESS)


"""
func _process(delta):
	if is_into and player:
		if player.power > 100:
			player.power -= 1
		if player._velocity.x > 100:
			player._velocity.x -= 1
		if PlayerData.lives < 100:
			PlayerData.lives += 1
"""


func _on_VisibilityEnabler_screen_exited() -> void:
	queue_free()

