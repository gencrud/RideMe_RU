extends MarginContainer
class_name OptionMenu

var bike_cfg: BikeCfg = load(PathData.BIKE_MODEL).new()
var player_bike_cfg: PlayerBikeCfg = load(PathData.PLAYER_BIKE_MODEL).new()


func _on_ResetGame_pressed():
	reset_game_config()
	
	var audio_btn_run = preload("res://media/ui/btn_run.wav")
	$VBoxContainer/Return/AudioStreamPlayer2D.set_stream(audio_btn_run)
	$VBoxContainer/Return/AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(1), "timeout")
	
	var res := get_tree().change_scene(PathData.RES_MAIN_MENU_TSCN)
	assert(res != OK, "ERROR: " + str(self) + " " + str(res) + "_on_ResetGame_pressed and change_scene")

func reset_game_config():
	clear_game_config()

	create_bikes()
	create_player_bike()
	create_levels()
	create_tracks()
	
	create_player_track(0)
	
	# START::Todo: City 1th track will need buy in feature
	# create_player_track(4)

	PlayerData._ready()
	GameData._ready()


func clear_game_config():
	bike_cfg.clear()
	player_bike_cfg.clear()
	GameData.track_cfg.clear()
	GameData.player_track_cfg.clear()
	
	GameData.current_level = {}
	GameData.current_track = null
	PlayerData.player_bike = null


func create_player_bike() -> void:
	var res := player_bike_cfg.create("Empty")
	# assert(res != OK, "ERROR: create_player_bike Empty")


func create_bikes() -> void:
	EmptyBike.create_for_cfg()
	SataurBike.create_for_cfg()
	DrawsterBike.create_for_cfg()
	

func create_levels() -> void:
	var res := GameData.level_cfg.create(1, "Mountains")
	# assert(res != OK, "ERROR: create_levels Mountains")
	res = GameData.level_cfg.create(2, "City")
	# assert(res != OK, "ERROR: create_levels City")


func create_tracks() -> void:
	Level_0.create_for_cfg()
	Level_1.create_for_cfg()
	Level_2.create_for_cfg()
	Level_3.create_for_cfg()
	
	Level2_0.create_for_cfg()
	Level2_1.create_for_cfg()
	Level2_2.create_for_cfg()


func create_player_track(track_train_id: int = 0) -> void:
	var track_section: String = GameData.track_cfg.get_section(track_train_id)
	var track_resource = GameData.track_cfg.get_resource(track_section)
	
	var player_track_section := track_section.replace(GameData.track_cfg.prefix, GameData.player_track_cfg.prefix)
	var res := GameData.player_track_cfg.create(track_section, player_track_section)
	# assert(res != OK, "ERROR: OptionMenu create_player_track " + str(track_train_id))
	
	GameData.track_cfg.set_state(track_section, LevelTrackStates.ACTIVE)

	GameData.current_track = load(track_resource).instance()
	GameData.current_track.resource = track_resource
