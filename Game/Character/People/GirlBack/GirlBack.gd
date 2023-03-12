extends RigidBody2D
class_name GirlBack

var animation: AnimationPlayer

onready var audio_girl_scream = preload("res://media/characters/girl_scream.wav")


func _ready() -> void:
	rotation_degrees = 0
	set_physics_process(false)


func _on_tree_entered() -> void:
	animation = $AnimationPlayer
	animation.play("walk")


func _on_StopmDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.do_collision(animation, body, self)
		$Audio.set_stream(audio_girl_scream)
		$Audio.play()


func _on_GirlBack_tree_exited():
	animation.stop()
