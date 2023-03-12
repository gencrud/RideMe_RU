extends RigidBody2D
class_name Plank

onready var added_bonuse: bool = false
onready var live: int = 2
onready var refer := self


func _ready():
	$Particles2D.visible = false
	
	set_physics_process(false)
	set_process(false)
	visible = false
	get_parent().remove_child(self)
		
	
func _on_StompDetector_body_entered(body: Node2D) -> void:		
	if "Player" == body.name:
		live -= 1
		modulate = Color.tomato
		modulate.a = 0.9
	
	if live == 0:
		die()
	

func _on_StompDetector_body_exited(body: Node2D) ->void:
	if live == 0:
		die()


func _on_VisibilityEnabler2D_screen_entered() -> void:
	visible = true
	get_parent().add_child(refer)
	

func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()


func die():
	if not added_bonuse:
		add_bonuse()
	
	live = 0
	modulate = Color.white
	$Sprite.visible = false
	$StompDetector.visible = false
	$Collision.disabled = true
	
	$Particles2D.visible = true
	$Particles2D.emitting = true
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()


func add_bonuse() -> void:
	var rm: RM = preload("res://Game/Character/RM/RM.tscn").instance()
	rm.position = Vector2(position.x + 300.0, position.y - 48.0)
	get_parent().add_child(rm)
	added_bonuse = true
