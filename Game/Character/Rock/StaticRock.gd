extends StaticBody2D

onready var _player_stomp_detecter = load(PathData.PATH_PLAYER_STOMP_DETECTER)
onready var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
onready var player_stomp_detecter = _player_stomp_detecter.new()


func _on_StompDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		player_stomp_detecter.player = body
		player_stomp_detecter.on_player_entered()

		animate_people.hit_player(body, 1)


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
