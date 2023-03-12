extends BonusArea
class_name Refit


func _on_body_entered(body: Player) -> void:
	._on_body_entered(body)
	
	if is_instance_valid(body) and body.name == "Player":
		PlayerData.lives += 50


func _on_body_exited(body: Player) -> void:
	._on_body_exited(body)
	

func _on_VisibilityNotifier_screen_exited() -> void:
	._on_VisibilityNotifier_screen_exited()
