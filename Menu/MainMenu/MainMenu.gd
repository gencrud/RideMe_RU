tool
extends MarginContainer
class_name MainMenu

export (String, FILE) var game_tscn: = ""

var path_data: PathData = preload("res://Autoload/PathData.gd").new()
var track_cfg: TrackCfg = preload("res://config/TrackCfg.gd").new()

onready var field_log: FieldLog = preload("res://components/field_log/FieldLog.gd").new()
onready var btn_bike_menu: TextureIconButton = $HBoxContainer/VBoxContainer/MenuOptions/BikeMenu
onready var btn_level_menu: TextureIconButton = $HBoxContainer/VBoxContainer/MenuOptions/LevelMenu
onready var btn_options: TextureIconButton = $HBoxContainer/VBoxContainer/MenuOptions/Options
onready var btn_play: TextureButton = $HBoxContainer/VBoxContainer/MenuOptions/Play


func _ready() -> void:
	if not can_start_play():
		btn_play.modulate.a = 0.4
		btn_play.type = "Error"
	else:
		btn_play.modulate.a = 1
		btn_play.type = "Run"
		btn_play.anim_flicker()

	btn_play.hint_tooltip = "Play the %s level track on %s bike" % [
		GameData.current_level.title if GameData.current_level else "no",
		PlayerData.player_bike.title if PlayerData.player_bike else "no",
	]

	if not PlayerData.player_bike:
		btn_bike_menu.anim_flicker()
	
	init_btn_level_menu()
	show_player_bike()
	show_current_track()


func _on_Play_pressed() -> void:
	if not can_start_play():
		field_log.target = $"."
		field_log_start_play()
	else:
		yield(get_tree().create_timer(0.6), "timeout")
		var res := get_tree().change_scene(game_tscn)
		if res != OK:
			printerr("ERROR: " + str(self) + " " + str(res) + "_on_Play_pressed and change_scene")


func can_start_play() -> bool:
	return is_instance_valid(PlayerData.player_bike) and is_instance_valid(GameData.current_track) and GameData.current_level # and has_tracks


func field_log_start_play() -> void:
	field_log.clear()
	
	if not PlayerData.player_bike:
		# var error_en = "Bike not selected. You don't have a bike!"
		var error = "Велосипед не выбран. У тебя нет велосипеда!"
		field_log.error(error)
	elif not GameData.current_level:
		# var error_en = "Level not selected. You don't have a level!"
		var error = "Текущий уровень не выбран. У тебя нет текущего уровня!"
		field_log.error(error)
	elif not GameData.current_track:
		# var error_en = "Track of level not selected. You don't have a track!"
		var error = "Трэк уровеня не выбран. У тебя нет текущего трэка!"
		field_log.error(error)
	else:
		# var error_en = "Undefined error. You cannot start play. Try ro reboot game"
		var error = "Неопределенная ошибка. Вы не можете начать играть. Попробуйте перезагрузить игру"
		field_log.error(error)


func init_btn_level_menu():
	if track_cfg.get_id(track_cfg.get_section(0)) != 0:
		btn_level_menu.modulate.a = 0.4
		btn_level_menu.disabled = true
	else:
		btn_level_menu.modulate.a = 1
		btn_level_menu.disabled = false
				
		if not GameData.current_track:
			btn_level_menu.anim_flicker()


func show_player_bike() -> void:
	if PlayerData.player_bike:
		var _sataur: TextureRect = $HBoxContainer/CenterContainer/Characters/Sataur
		var _drawster: TextureRect = $HBoxContainer/CenterContainer/Characters/Drawster

		if _sataur.name == PlayerData.player_bike.title:
			_sataur.modulate.a = 1
			_drawster.visible = false
		elif _drawster.name == PlayerData.player_bike.title:
			_drawster.modulate.a = 1
			_sataur.visible = false


func show_current_track() -> void:
	if is_instance_valid(GameData.current_track):
		var _current_track: NinePatchRect = $HBoxContainer/CenterContainer/CurrentTrack
		_current_track.visible = true
		_current_track.texture = GameData.current_track.texture


func _get_configuration_warning() -> String:
	var msg:String = "Game scene must be set "
	return msg if game_tscn == "" else ""
