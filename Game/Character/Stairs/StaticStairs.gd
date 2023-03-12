extends StaticBody2D
class_name StaticStairs

var player: Player
var _player_stomp_detecter = load(PathData.PATH_PLAYER_STOMP_DETECTER)
onready var player_stomp_detecter: PlayerStompDetecter = _player_stomp_detecter.new()
onready var refer: StaticStairs = self


func _ready() -> void:
	player_stomp_detecter.ready_for_player(global_position)
	# To test v 0.0.1
	# set_physics_process(false)
	# set_process(false)
	# get_parent().remove_child(self)


func _on_StompDetector_body_entered(body: Node) -> void:
	if "Player" == body.name:
		player = body
		player_stomp_detecter.player = player
		player_stomp_detecter.on_player_entered()
		
		var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
		animate_people.hit_player(player, 1)


func _on_VisibilityNotifier2D_screen_entered():
	player_stomp_detecter.on_visibility_screen_entered_for_player(refer)
	visible = true
	# player = get_player_node()
	# get_parent().add_child(refer)
	

func _on_VisibilityNotifier2D_screen_exited() -> void:
	player_stomp_detecter.on_visibility_screen_exited_for_player(global_position)
	# player = get_player_node()
	# if player.global_position.x > global_position.x:		
	# 	queue_free()
