extends "res://Game/Player/Actor.gd"
class_name KSMan

onready var animation: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	set_physics_process(false)


func _process(delta: float) -> void:
	if not animation.is_playing():
		animation.play("walk")


func _physics_process(delta: float) -> void:
	_velocity.y += (gravity * delta) * 10
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_StopmDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.do_collision(animation, body, self)


func _on_KSMan_tree_entered():
	_velocity.x = -speed.x if scale.x > 0 else speed.x


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
