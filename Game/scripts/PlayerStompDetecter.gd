extends Node
class_name PlayerStompDetecter

var player: Player
var audio_broke_bike = preload("res://media/move/broken.wav")


func on_player_entered() -> void:
	if "Player" == player.name:
		player.get_node('AudioMove').set_stream(audio_broke_bike)
		player.get_node('AudioMove').play()
		
		player.anim_player.stop()
		player.anim_player.play("collision")
		PlayerData.lives -= 1
		
		if player.speed.x > player.max_speed / 2:
			PlayerData.lives -= 10
		elif player.speed.x > (player.max_speed * 90 / 100):
			PlayerData.lives -= 30
		
		if PlayerData.lives < 0:
			var die_player = load(PathData.PATH_DIE_PLAYER).new()
			die_player.from_broke_bike(player)


func ready_for_player(global_position: Vector2) -> void:
	player = get_player_node()
	
	if player and player.global_position.x > global_position.x + 3000.0:
		set_physics_process(false)
		set_process(false)
		# get_parent().remove_child(self)
		get_parent().call_deferred("remove_child", self)


func on_visibility_screen_exited_for_player(global_position: Vector2):
	player = get_player_node()
	if player and player.global_position.x > global_position.x:		
		queue_free()


func on_visibility_screen_entered_for_player(refer: Node) -> void:
	player = get_player_node()
	# get_parent().call_deferred("add_child", refer)
	if player:
		get_parent().add_child(refer)


func get_player_node(path: String = '/root/Game/Player') -> Player:
	if not player:
		return get_node(path) as Player   # noqa
	return player
