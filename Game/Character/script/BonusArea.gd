extends Area2D
class_name BonusArea

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	set_physics_process(false)


func _on_body_entered(body: Player) -> void:
	if is_instance_valid(body) and body.name == "Player":
		body.anim_player.play(PlayerData.ANIMATION_SUCCESS)
		body.get_node('AudioMove').set_stream(body.audio_colected)
		body.get_node('AudioMove').play()
		$Particles2D.emitting = true


func _on_body_exited(body: Player) -> void:
	anim_player.play("fade_out")
	

func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
