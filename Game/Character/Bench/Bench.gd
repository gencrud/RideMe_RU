extends StaticBody2D
class_name Bench

var _player_stomp_detecter = load(PathData.PATH_PLAYER_STOMP_DETECTER)

onready var player_stomp_detecter = _player_stomp_detecter.new()


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()


func _on_StompDetector_body_entered(body: Node2D) -> void:
	if "Player" == body.name:
		player_stomp_detecter.player = body
		player_stomp_detecter.on_player_entered()
		
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.hit_player(body, 0)
		
		body._velocity.x -= 4
