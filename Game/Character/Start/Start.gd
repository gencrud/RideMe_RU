extends Area2D
class_name Start  # or Finish


func _on_Start_body_entered(body: KinematicBody2D) -> void:
	if body.name == 'Player' and GameData.current_track.are_you_win():
		finished(body)


func finished(player: Player):
	var tree: SceneTree = player.get_tree()
	var pause_screen: GameScreenPause = tree.current_scene.get_node("GUI/Canvas/GameScreenPause")

	yield(player.get_tree().create_timer(1), "timeout")
		
	if is_instance_valid(pause_screen):
		pause_screen.set_paused(true)
		var continue_btn: TextureIconButton = pause_screen.get_node("PauseRect/Container/ContinueBtn")
		continue_btn.visible = false
	
		var pause_win = load("res://Game/GameScreen/GamePauseWin.gd").new()
		PlayerData.set_score(player.position.x)
		PlayerData.set_type_title(pause_win.TitleChoices.WIN_PLAYER)
		
		pause_win.do_init(pause_screen.title, pause_screen.pause_rect)
		# player.queue_free() # ????
