extends BaseArea2D
class_name Puddle

onready var refer: Puddle = self


func _ready() -> void:
	set_physics_process(false)
	set_process(false)
	visible = false
	get_parent().remove_child(self)
	
	
func _on_body_entered(body):
	if body.name == "Player":
		._on_body_entered(body)
		body.anim_player.play(PlayerData.ANIMATION_COLLISION)
		
		$Particles.emitting = true
		PlayerData.lives -= 1


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func _on_VisibilityEnabler_screen_entered() -> void:
	visible = true
	get_parent().add_child(refer)
