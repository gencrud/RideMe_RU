extends Node
# PlayerData
signal score_updated
signal lives_updated
signal rms_updated
signal time_level_updated

const ANIMATION_SUCCESS: String = "success"
const ANIMATION_DANGER: String = "danger"
const ANIMATION_COLLISION: String = "collision"

var score: = 0 setget set_score # not used anywhere
var time_level_count: int = 0
var time_level: = 0 setget set_time_level
var rms_count: int = 0
var type_title: int = -1

var rms: int = PlayerBikeCfg.DEFAULT_VALUE_RMS setget set_rms
var lives: int = PlayerBikeCfg.DEFAULT_VALUE_LIVES setget set_lives
var player_bike: EmptyBike

onready var player_bike_cfg: PlayerBikeCfg = load(PathData.PLAYER_BIKE_MODEL).new()

var lives_value: Label
var rms_value: Label
var time_level_value: Label
var gui_time: VBoxContainer
var player: KinematicBody2D


func _ready():
	if has_node(PathData.PATH_LIVES_COUNTER_VALUE):
		lives_value = get_node(PathData.PATH_LIVES_COUNTER_VALUE)
	if has_node(PathData.PATH_RMS_COUNTER_VALUE):
		rms_value = get_node(PathData.PATH_RMS_COUNTER_VALUE)
	if has_node(PathData.PATH_TIME_LEVEL_VALUE):
		time_level_value = get_node(PathData.PATH_TIME_LEVEL_VALUE)
	if has_node(PathData.PATH_GUI_TIME):
		gui_time = get_node(PathData.PATH_GUI_TIME)
	if has_node(PathData.PATH_PLAYER):
		player = get_node(PathData.PATH_PLAYER)
	
	var player_bike_data: = player_bike_cfg.first()
	set_player_data(player_bike_data)
	
	if not player_bike_data.empty() and player_bike_data["bike_title"] != "Empty":
		var bike_file = 'Sataur'
		if player_bike_data["bike_title"] == 'Дравстер':
			 bike_file = 'Drawster'
		
		player_bike = load("res://Game/Bike/" + bike_file + "Bike.gd").new()
		player_bike.set_player_bike(player_bike_data)

	if is_instance_valid(player) and is_instance_valid(GameData.current_track):
		time_level = GameData.current_track.init_time_level


func reset_progress() -> void:
	_ready()
	
	if not is_instance_valid(player):
		player = load(PathData.PATH_PLAYER).new()
		
	rms_count = 0
	time_level_count = 0
	score = 0
	set_lives(lives)


func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")


func set_lives(value: int) -> void:
	if not is_instance_valid(lives_value):
		lives_value = get_node(PathData.PATH_LIVES_COUNTER_VALUE)
	
	if lives != value:
		var anim_name = ANIMATION_DANGER if lives > value else ANIMATION_SUCCESS
		var lives_counter_animation: AnimationPlayer = get_node(PathData.PATH_LIVES_COUNTER + "/AnimationPlayer")

		lives = value
		lives_value.text = str(lives)
		lives_counter_animation.play(anim_name)

		emit_signal("lives_updated")


func set_rms(value: int, is_game_mode:= true) -> void:
	var _value = str(rms)
	rms = value

	# when Splash as main sceen
	if not is_instance_valid(rms_value):
		if has_node(PathData.PATH_RMS_COUNTER_VALUE):
			rms_value = get_node(PathData.PATH_RMS_COUNTER_VALUE)
	# when BikeMenu as main sceen
	if not is_instance_valid(rms_value):
		var path = "/root/BikeMenu/TextureRect/RMCounter/Background/Value"
		rms_value = get_node(path)
	# when LevelMenu as main sceen
	if not is_instance_valid(rms_value):
		var path = "/root/LevelMenu/TextureRect/RMCounter/Background/Value"
		rms_value = get_node(path)

	if is_game_mode:
		rms_count += 1
		_value += ' | ' + str(rms_count)
	
	rms_value.set_text(_value)
	emit_signal("rms_updated")


func save_rms(rm: int) -> void:
	player_bike_cfg.set_rm(rm)
	set_rms(rm, false)


func set_time_level(value: int) -> void:
	# when Splash as main sceen
	if not is_instance_valid(time_level_value):
		time_level_value = get_node(PathData.PATH_TIME_LEVEL_VALUE)
		
	# when Game as main sceen
	time_level = value
	time_level_value.set_text(str(time_level) + ' | ' + str(time_level_count))
	emit_signal("time_level_updated")


func set_time_level_count(_player: KinematicBody2D) -> int:
	if not is_instance_valid(player): 
		player = _player

	time_level_count += 1
	
	var finish: Start = GameData.current_track.find_node('Finish')
	var finish_pos_x = player.position.x + 888
	
	if GameData.current_track.are_you_win():	
		if is_instance_valid(finish):
			finish.position.x = finish_pos_x
		else:
			var _finish = load("res://Game/Character/Start/Start.tscn")
			finish = _finish.instance()
			finish.z_index = 1
			finish.set_position(Vector2(finish_pos_x, player.position.y + 100))
			GameData.current_track.add_child(finish)

	return time_level_count


func set_type_title(_type_title: int):
	type_title = _type_title


func set_player_data(player_bike_data: Dictionary) -> void:
	if not player_bike_data.empty():
		rms = player_bike_data["rm"]
		lives = player_bike_data["lives"]
