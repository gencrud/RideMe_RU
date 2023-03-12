extends "res://Game/GameScreen/GamePauseDie.gd"
class_name GamePauseWin


var rect_color_win: = Color(0.25, 0.56, 0.34, 0.8)


func do_init(title: Label, pause_rect: ColorRect) -> void:
	if GameData.current_track.are_you_win() and PlayerData.type_title == TitleChoices.WIN_PLAYER:
		var next_level_btn: TextureIconButton = pause_rect.get_node("Container/NextLevelBtn")
		next_level_btn.visible = true
		
		set_title_and_rect_color(title, pause_rect)
		set_screen_items(pause_rect)
		update_as_win_cfg()


func get_traveled_time() -> String:
	var path_gui_time: String = "/root/Game/GUI/Canvas/HBoxContainer/Time/Container/Value"
	
	if GameData.current_track.has_node(path_gui_time):
		var gui_time: String = GameData.current_track.get_node(path_gui_time).text
		if " : " in gui_time:
			gui_time = gui_time.replace(" ", "")
		return gui_time
	return "00:00:00"


func set_screen_items(pause_rect: ColorRect) -> void:
	pause_rect.get_node("LabelItems").visible = true
	pause_rect.get_node("ResourceContainer").visible = true
	
	var rm_item_res_value: Label = pause_rect.get_node("ResourceContainer/RMItemResource/Value")
	var hourgrass_item_res_value: Label = pause_rect.get_node("ResourceContainer/HourgrassItemResource/Value")
	rm_item_res_value.set_text(str(PlayerData.rms_count))
	hourgrass_item_res_value.set_text(str(PlayerData.time_level_count))
	
	var travel_time = 'Travel time:..................%s' % [get_traveled_time()]
	var distance_travel = 'Distance traveled:....%d m' % [PlayerData.score / 100]
	pause_rect.get_node("LabelItems").set_text(travel_time + '\r\n'  + distance_travel)
	

func set_title_and_rect_color(title: Label, pause_rect: ColorRect):
	title.set_text("You win!")
	pause_rect.get_node("Description").visible = true
	pause_rect.get_node("Description").set_text(get_info())
	pause_rect.color = rect_color_win


func get_info() -> String:
	if GameData.current_track.title:
		return GameData.current_track.title + ": " + GameData.current_track.init_issue()
	return ": " + GameData.current_track.init_issue()


func update_as_win_cfg():
	if GameData.current_track:
		# 
		# TODO: remode from PATHDATA 
		var track_section: = GameData.track_cfg.get_section(GameData.current_track.ID)
		var player_track_section: = track_section.replace(GameData.track_cfg.prefix, GameData.player_track_cfg.prefix)
		
		GameData.track_cfg.set_state(track_section, LevelTrackStates.PASSED)
		GameData.player_track_cfg.set_best_time(player_track_section, get_traveled_time())

		PlayerData.rms_count = 0
		PlayerData.save_rms(PlayerData.rms)
		
		if GameData.track_cfg.has_passed_level(GameData.current_track.level_id):
			var level_section: String = GameData.level_cfg.get_section(GameData.current_track.level_id)
			GameData.level_cfg.set_passed_at(level_section)
