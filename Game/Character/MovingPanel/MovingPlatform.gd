extends KinematicBody2D
class_name MovingPlatform

const MOVE_SPEED = 100

var has_move_up = true
onready var start_pos_y = position.y


func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	if has_move_up:
		move_up(delta)
	else:
		move_down(delta)


func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()


func move_up(dt: float):
	if position.y > start_pos_y:
		position.y -= dt * MOVE_SPEED


func move_down(dt: float):
	position.y += dt * MOVE_SPEED


func _on_Area2D_body_entered(body) -> void:
	if body.name == "Player":
		has_move_up = false
		
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.play_collision(body.anim_player)
		animate_people.hit_player(body)



func _on_Area2D_body_exited(body) -> void:
	if body.name == "Player":
		has_move_up = true
