extends Area2D


func _on_VisibilityEnabler_screen_exited() -> void:
	queue_free()


func _ready() -> void:
	set_physics_process(false)
