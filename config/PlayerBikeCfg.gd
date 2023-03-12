extends Cfg
class_name PlayerBikeCfg

const FILE = "player_bike.cfg"

const KEY_BIKE_TITLE = "bike_title"
const KEY_RM = "rm"
const KEY_LIVES = "lives"
const KEY_MAX_SPEED = "max_speed"
const KEY_MAX_HEIGHT_JUMP = "max_height_jump"
const KEY_MAX_POWER = "max_power"
const DEFAULT_VALUE_RMS = 120
const DEFAULT_VALUE_LIVES = 100
var SECTION_1


func _init():
	prefix = "PlayerBike"
	path_file_cfg = RES + FILE
	config = get_config()
	SECTION_1 = get_section("1")


# getters

func get_bike_title(section: String = SECTION_1) -> String:
	return config.get_value(section, KEY_BIKE_TITLE)

func get_rm(section: String = SECTION_1) -> int:
	return config.get_value(section, KEY_RM)

func get_lives(section: String = SECTION_1) -> int:
	return config.get_value(section, KEY_LIVES)

func get_max_speed(section: String = SECTION_1) -> float:
	return config.get_value(section, KEY_MAX_SPEED)

func get_max_height_jump(section: String = SECTION_1) -> float:
	return config.get_value(section, KEY_MAX_HEIGHT_JUMP)

func get_max_power(section: String = SECTION_1) -> float:
	return config.get_value(section, KEY_MAX_POWER)


# setters

func set_rm(rm: int) -> void:
	config.set_value(SECTION_1, KEY_RM, rm)
	var res := config.save(path_file_cfg)
	if res != OK:
		printerr("ERROR: set_rm " + str(self) + ", path_file_cfg: " + path_file_cfg)


func set_bike_title(title: String) -> void:
	config.set_value(SECTION_1, KEY_BIKE_TITLE, title)
	var res := config.save(path_file_cfg)
	if res != OK:
		printerr("ERROR: set_bike_title " + str(self) + ", path_file_cfg: " + path_file_cfg)

func set_max_speed(val: float) -> void:
	config.set_value(SECTION_1, KEY_MAX_SPEED, val)
	var res := config.save(path_file_cfg)
	if res != OK:
		printerr("ERROR: set_max_speed " + str(self) + ", path_file_cfg: " + path_file_cfg)


func set_max_height_jump(val: float) -> void:
	config.set_value(SECTION_1, KEY_MAX_HEIGHT_JUMP, val)
	var res := config.save(path_file_cfg)
	if res != OK:
		printerr("ERROR: set_max_height_jump " + str(self) + ", path_file_cfg: " + path_file_cfg)


func set_max_power(val: float) -> void:
	config.set_value(SECTION_1, KEY_MAX_POWER, val)
	var res := config.save(path_file_cfg)
	if res != OK:
		printerr("ERROR: set_max_power " + str(self) + ", path_file_cfg: " + path_file_cfg)


# methods

func first() -> Dictionary:
	var records = get_all()
	var first: = {}
	if len(records) > 0:
		first = records[0]
	return first


func as_dict(section: String) -> Dictionary:
	return {
		KEY_BIKE_TITLE: get_bike_title(section),
		KEY_RM: get_rm(section),
		KEY_LIVES: get_lives(section),
		KEY_MAX_SPEED: get_max_speed(section),
		KEY_MAX_HEIGHT_JUMP: get_max_height_jump(section),
		KEY_MAX_POWER: get_max_power(section)
	}


func create(
	bike_title: String,
	rm: int = DEFAULT_VALUE_RMS,
	lives: int = DEFAULT_VALUE_LIVES,
	max_speed: float = 0.00, 
	max_height_jump: float = 0.00,
	max_power: float = 0.00
) -> int:

	var section = get_section("1")
	
	config.set_value(section, KEY_BIKE_TITLE, bike_title)
	config.set_value(section, KEY_RM, rm)
	config.set_value(section, KEY_LIVES, lives)
	config.set_value(section, KEY_MAX_SPEED, max_speed)
	config.set_value(section, KEY_MAX_HEIGHT_JUMP, max_height_jump)
	config.set_value(section, KEY_MAX_POWER, max_power)
	
	return config.save(path_file_cfg)
