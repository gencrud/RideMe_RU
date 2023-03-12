extends Node2D
class_name Level_0

export(Vector2) var start_position

# Keys
var ID: int
var issue: String
var num_win: int
var init_time_level: int
var price: int
var track_id: int 
var texture: Resource
var resource: String

# Level's keys
var level_id:int 
var title: String

var has_win: bool = false

var level_cfg: LevelCfg = load(PathData.LEVEL_MODEL).new()
var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
var player_track_cfg: PlayerTrackCfg = load(PathData.PLAYER_TRACK_MODEL).new()


func _init() -> void:
	ID = 0
	var section: = track_cfg.get_section(ID)
	init_level_track(section, ID)


func _ready():
	var background := get_parent().get_node('Background')
	var sky: Sprite = background.get_node('ParallaxSky/sky')
	
	sky.modulate = Color(1, 1, 1)
	init_start_position()
	background.visible = false
	

func init_start_position() -> void:
	var player:Player = get_parent().get_node('Player')
	if start_position != Vector2.ZERO and is_instance_valid(player):
		player.position = start_position
	else:
		printerr("Player's start position were not initialisated!")


func init_level_track(section: String, id_track: int) -> void:
	if not id_track and id_track != 0: 
		printerr("ERROR: init_level_track: " + section)
		
	if track_cfg.get_id(section) != null:
		level_id = track_cfg.get_level_id(section)
		title = level_cfg.get_title(level_cfg.get_section(level_id))
		num_win = track_cfg.get_num_win(section)
		init_time_level = track_cfg.get_init_time_level(section)
		price = track_cfg.get_price(section)
		track_id = track_cfg.get_id(section)
		issue = track_cfg.get_issue(section)
		resource = track_cfg.get_resource(section)
		texture = load(track_cfg.get_texture(section))


func init_issue() -> String:
	if not '%s' in issue:
		return "Todo: init issue ..."
	return issue % [num_win]


func are_you_win() -> bool:
	has_win = PlayerData.time_level_count >= num_win
	return has_win


func has_passed() -> bool:
	var section: String = track_cfg.get_section(str(GameData.current_track.ID))
	return track_cfg.has_passed_track(section)


static func create_for_cfg() -> void:
	var _resource: = "res://Game/Level/Level_0/Level_0.tscn"
	var _texture: = "res://Game/Level/assets/slides/track-00.png"
	var _num_win = 4
	var _init_time_level = 30
	var _price = 0
	var _issue: = "First experience: сollect the %s hourgrass"
	var _state: = LevelTrackStates.ACTIVE
	
	GameData.track_cfg.create(0, 1, _issue, _resource, _texture, _num_win, _init_time_level, _price, _state)
