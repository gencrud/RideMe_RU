extends Node
# GameData
var current_level: Dictionary
var current_track: Level_0

var track_cfg: TrackCfg = load(PathData.TRACK_MODEL).new()
var level_cfg: LevelCfg = load(PathData.LEVEL_MODEL).new()
var player_track_cfg: PlayerTrackCfg = load(PathData.PLAYER_TRACK_MODEL).new()


func _ready():
	# Get the first nedded track from all tracks of all levels
	var level_id: int
	var level_section: String
	var track_resource: String
	
	for section in track_cfg.config.get_sections():
		if track_cfg.get_state(section) in [LevelTrackStates.FAIL, LevelTrackStates.ACTIVE, LevelTrackStates.PASSED]:
			level_id = track_cfg.get_level_id(section)
			level_section = level_cfg.get_section(level_id)
			
			if GameData.level_cfg.get_passed_at(level_section).empty():
				track_resource = track_cfg.get_resource(section)

				if not track_resource.empty():
					current_track = load(track_resource).instance()
					current_level = level_cfg.as_dict(level_section)
					
					if track_cfg.get_state(section) != LevelTrackStates.PASSED:
						break


func reload_game(track_id: int):
	var track_section = track_cfg.get_section(track_id) 
	var track_resource = track_cfg.get_resource(track_section)
	var level_id = track_cfg.get_level_id(track_section)
	var level_section = level_cfg.get_section(level_id)
	
	if not track_resource.empty():
		current_track = load(track_resource).instance()
		current_level = level_cfg.as_dict(level_section)

