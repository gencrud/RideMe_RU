extends Cfg
class_name TrackCfg

const FILE = "tracks.cfg"

const KEY_ID = "id"
const KEY_LEVEL_ID = "level_id"
const KEY_ISSUE = "issue"
const KEY_RESOURCE = "resource"
const KEY_STATE = "state"
const KEY_TEXTURE = "texture"
const KEY_NUM_WIN = "num_win"
const KEY_INIT_TIME_LEVEL = "init_time_level"
const KEY_PRICE = "price"


func _init():
	prefix = "LevelTrack"
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func get_id(section: String) -> int:
	return config.get_value(section, KEY_ID)

func get_level_id(section: String) -> int:
	return config.get_value(section, KEY_LEVEL_ID)

func get_resource(section: String) -> String:
	return config.get_value(section, KEY_RESOURCE)

func get_issue(section: String) -> String:
	return config.get_value(section, KEY_ISSUE) # % [get_num_win(section)]

func get_state(section: String) -> int:
	return config.get_value(section, KEY_STATE)

func get_texture(section: String) -> String:
	return config.get_value(section, KEY_TEXTURE)

func get_num_win(section: String) -> int:
	return config.get_value(section, KEY_NUM_WIN)
	
func get_init_time_level(section: String) -> int:
	return config.get_value(section, KEY_INIT_TIME_LEVEL)

func get_price(section: String) -> int:
	return config.get_value(section, KEY_PRICE)


 # setters

func set_state(current_level_SECTION: String, state: int):
	config.set_value(current_level_SECTION, KEY_STATE, state)
	var res := config.save(path_file_cfg)
	assert(not res, "ERROR: set_state " + str(self) + ", path_file_cfg: " + path_file_cfg)


# methods

func get_tracks(level_id: int) -> Array:
	var store = []
	for section in config.get_sections():
		if get_level_id(section) == level_id:
			store.append(as_dict(section))
	return store


func get_active_track(level_id: int) -> Dictionary:
	var track: Dictionary = {}
	for section in config.get_sections():
		if get_level_id(section) == level_id and get_state(section) == LevelTrackStates.ACTIVE:
			track = as_dict(section) # as last item
	return track


func get_passed_tracks(level_id: int) -> Array:
	var store = []
	for section in config.get_sections():
		if get_level_id(section) == level_id and get_state(section) == LevelTrackStates.PASSED:
			store.append(as_dict(section))
	return store


func get_fail_tracks(level_id: int) -> Array:
	var store = []
	for section in config.get_sections():
		if get_level_id(section) == level_id and get_state(section) == LevelTrackStates.FAIL:
			store.append(as_dict(section))
	return store


func has_passed_track(section: String) -> bool:
	return LevelTrackStates.PASSED == get_state(section)


func has_passed_level(level_id: int) -> bool:
	var count_tracks: int = 0
	var count_passed_tracks: int = 0
	count_tracks = len(get_tracks(level_id))
	count_passed_tracks = len(get_passed_tracks(level_id))
	return count_tracks == count_passed_tracks


func as_dict(section: String) -> Dictionary:
	return {
		KEY_ID: get_id(section),
		KEY_LEVEL_ID: get_level_id(section),
		KEY_STATE: get_state(section),
		KEY_ISSUE: get_issue(section),
		KEY_RESOURCE: get_resource(section),
		KEY_TEXTURE: get_texture(section),
		KEY_NUM_WIN: get_num_win(section),
		KEY_INIT_TIME_LEVEL: get_init_time_level(section),
		KEY_PRICE: get_price(section)
	}


func create(
	id: int,
	level_id: int, 
	issue: String,
	resource: String,
	texture: String,
	num_win: int,
	init_time_level: int,
	price: int = 0,
	state: int = LevelTrackStates.PAY
) -> int:

	var section = get_section(id)
	
	config.set_value(section, KEY_ID, id)
	config.set_value(section, KEY_LEVEL_ID, level_id)
	config.set_value(section, KEY_ISSUE, issue)
	config.set_value(section, KEY_RESOURCE, resource)
	config.set_value(section, KEY_STATE, state)
	config.set_value(section, KEY_TEXTURE, texture)
	config.set_value(section, KEY_NUM_WIN, num_win)
	config.set_value(section, KEY_INIT_TIME_LEVEL, init_time_level)
	config.set_value(section, KEY_PRICE, price)
	
	return config.save(path_file_cfg)


