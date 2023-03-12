extends StaticBody2D
class_name RoadBody

export(bool) var has_repeat = false;

var player: Player
var _player_stomp_detecter = load(PathData.PATH_PLAYER_STOMP_DETECTER)

onready var road_width = $sprite.texture.get_size().x
onready var refer: RoadBody = self
onready var player_stomp_detecter: PlayerStompDetecter = _player_stomp_detecter.new()


func _ready() -> void:
	player_stomp_detecter.ready_for_player(global_position)
	# visible = false


func repeat_two_sprites():
	if has_repeat:
		_repeat_two_sprites()


func _repeat_two_sprites():
	if not has_repeat:
		push_error("[ERROR] Advice: The 'Has Repeat' variable has not set at 'true'")
		return

	if player.position.x > $sprite2.position.x + road_width:
		$sprite.position.x = $sprite2.position.x + road_width
		$Collision.position.x = $sprite2.position.x + road_width
	if player.position.x > $sprite.position.x + road_width:
		$sprite2.position.x = $sprite.position.x + road_width
		$Collision2.position.x = $sprite.position.x + road_width


func _on_VisibilityEnabler2D_screen_exited():
	player_stomp_detecter.on_visibility_screen_exited_for_player(global_position)


func _on_VisibilityEnabler2D_screen_entered() -> void:
	player_stomp_detecter.on_visibility_screen_entered_for_player(refer)
	visible = true
