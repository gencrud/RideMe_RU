class_name GamePauseDie


var rect_color_lose: = Color(0.56, 0.25, 0.25, 0.8)

# EN VERSION
# const TIME_UP_TEXT: String = 'Your time is up'
# const BROKE_BIKE_TEXT: String = 'You broke the bike'
# const FELL_TEXT: String = 'You fell and you need \r\n to try again'
# const HIT_PERSON_TEXT: String = 'You hit a person'
# const BITTEN_BY_DOG_TEXT = "You've been bitten by a dog and \r\n you need to start over!"
# RU VERSION
const TIME_UP_TEXT: String = 'Ваше время вышло'
const BROKE_BIKE_TEXT: String = 'Ты сломал велосипед'
const FELL_TEXT: String = 'Вы упали, и вам нужно \r\n повторить попытку'
const HIT_PERSON_TEXT: String = 'Вы сбили человека'
const BITTEN_BY_DOG_TEXT = "You were bitten by a dog. Аф - аф!"

enum TitleChoices {
	TIME_UP, BROKE_BIKE, FELL, HIT_PERSON, BITTEN_BY_DOG
	WIN_PLAYER 
}


func do_init(title: Label, pause_rect: ColorRect) -> void:
	if PlayerData.lives <= 0 and PlayerData.type_title > -1:
		set_title_and_rect_color(title, pause_rect)
		update_as_fail_cfg()


func set_title_and_rect_color(title: Label, pause_rect: ColorRect):
	if PlayerData.type_title != TitleChoices.WIN_PLAYER:
		title.set_text(get_info())
		pause_rect.color = rect_color_lose


func get_info() -> String:
	#if PlayerData.type_title == TitleChoices.WIN_PLAYER:
	#	description.set_text(PlayerData.current_level.title)
	
	# var title_en = "Losing: "
	var title = "Проигрыш: "
	 
	if PlayerData.type_title == TitleChoices.FELL:
		title += FELL_TEXT
	elif PlayerData.type_title == TitleChoices.BROKE_BIKE:
		title += BROKE_BIKE_TEXT
	elif PlayerData.type_title == TitleChoices.TIME_UP:
		title += TIME_UP_TEXT
	elif PlayerData.type_title == TitleChoices.HIT_PERSON:
		title += HIT_PERSON_TEXT
	elif PlayerData.type_title == TitleChoices.BITTEN_BY_DOG:
		title += BITTEN_BY_DOG_TEXT
		
	return title


func update_as_fail_cfg():
	# Update writes to .cfg files
	if is_instance_valid(GameData.current_track):
		var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
		var player_track_cfg: PlayerTrackCfg = load(PathData.PLAYER_TRACK_MODEL).new()
		
		var track_section: = track_cfg.get_section(GameData.current_track.ID)
		var player_track_section: = track_section.replace(track_cfg.prefix, player_track_cfg.prefix)
	
		track_cfg.set_state(track_section, LevelTrackStates.FAIL)
		player_track_cfg.set_best_time(player_track_section, "00:00:00")
