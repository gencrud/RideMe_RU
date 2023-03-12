extends Node
class_name DiePlayer

var player: Player
var end_game_scr = load(PathData.PATH_PAUSE_DIE).new()
var audio_broke_bike = preload("res://media/move/broken.wav")
var audio_btn_error = preload("res://media/ui/btn_error.wav")


func from_time_up(_player: Player) -> void:
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.TIME_UP)
	PlayerData.set_score(player.global_position.x)
	die(true)


func from_hir_person(_player: Player) -> void:
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.HIT_PERSON)
	PlayerData.set_score(int(player.global_position.x))
	die()


func from_fell(_player: Player):
	_player.position = Vector2.ZERO
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.FELL)
	PlayerData.set_score(int(player.global_position.x))
	die(true)
	

func from_broke_bike(_player: Player):
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.BROKE_BIKE)
	PlayerData.set_score(int(player.global_position.x))
	die()


func from_bitten_by_dog(_player: Player) -> void:
	init_player(_player)
	PlayerData.set_type_title(end_game_scr.TitleChoices.BITTEN_BY_DOG)
	PlayerData.set_score(player.global_position.x)
	die()


func die(force: bool = false) -> void:
	if force: 
		PlayerData.lives = 0
	
	if PlayerData.lives <= 0 and player:
		player.get_node('AudioMove').set_stream(audio_btn_error)
		player.get_node('AudioMove').play()
	
		var tree: SceneTree = player.get_tree()
		var pause_screen: GameScreenPause = tree.current_scene.get_node("GUI/Canvas/GameScreenPause")

		yield(player.get_tree().create_timer(1.6), "timeout")
		
		if is_instance_valid(pause_screen):
			pause_screen.set_paused(true)

			var next_level_btn: TextureIconButton = pause_screen.get_node("PauseRect/Container/NextLevelBtn")
			var continue_btn: TextureIconButton = pause_screen.get_node("PauseRect/Container/ContinueBtn")
			next_level_btn.visible = false
			continue_btn.visible = false
		
			var pause_die = preload("res://Game/GameScreen/GamePauseDie.gd").new()
			pause_die.do_init(pause_screen.title, pause_screen.pause_rect)


func init_player(_player: Player) -> void:
	_player.get_node('AudioMove').set_stream(audio_broke_bike)
	_player.get_node('AudioMove').play()
	
	if not is_instance_valid(player):
		player = _player
