extends Cfg
class_name PlayerTrackCfg

const FILE:  = "player_tracks.cfg"

const KEY_ID: = "id"
const KEY_TRACK_ID: = "track_id"
const KEY_PAID_AT: = "paid_at"
const KEY_BEST_TIME_AT: = "best_time_at"
const KEY_ATTEMPTS: = "attempts"


func _init():
	prefix = "PlayerTrack"
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func get_id(track) -> int:
	return config.get_value(track, KEY_ID)

func get_track_id(track) -> int:
	return config.get_value(track, KEY_TRACK_ID)

func get_paid_at(track) -> String:
	return config.get_value(track, KEY_PAID_AT)

func get_best_time_at(track) -> String:
	return config.get_value(track, KEY_BEST_TIME_AT)

func get_attempts(track) -> Array:
	var attempts = config.get_value(track, KEY_ATTEMPTS)
	if attempts:
		return attempts
	return []


# setters
func set_best_time(track_section: String, value: String) -> void:
	var attempts: Array = get_attempts(track_section)
	attempts.append(value)

	var _old_value = get_best_time_at(track_section)
	if _old_value and _old_value != "00:00" and _old_value != "00:00:00":
		var mimsecmls_value: Array = value.rsplit(":", true, 2)
		var old_value: Array = _old_value.rsplit(":", true, 2)

		if int(old_value[0]) < int(mimsecmls_value[0]):
			value = _old_value
		elif int(old_value[0]) == int(mimsecmls_value[0]) and int(old_value[1]) < int(mimsecmls_value[1]):
			value = _old_value
		elif int(old_value[0]) == int(mimsecmls_value[0]) and int(old_value[1]) == int(mimsecmls_value[1]) and int(old_value[2]) < int(mimsecmls_value[2]):
			value = _old_value

	config.set_value(track_section, KEY_BEST_TIME_AT, value)
	config.set_value(track_section, KEY_ATTEMPTS, attempts)
	var res := config.save(path_file_cfg)
	assert(not res, "ERROR: set_best_time " + str(self) + ", path_file_cfg: " + path_file_cfg)


# metthods

func create(track_section: String, player_track_section: String) -> int:
	var track_id := int(track_section.split("_")[1])
	
	config.set_value(player_track_section, KEY_ID, track_id)
	config.set_value(player_track_section, KEY_TRACK_ID, track_id)
	config.set_value(player_track_section, KEY_PAID_AT, OS.get_datetime())
	config.set_value(player_track_section, KEY_BEST_TIME_AT, "00:00")
	config.set_value(player_track_section, KEY_ATTEMPTS, [])
	
	return config.save(path_file_cfg)
