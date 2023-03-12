extends Level_0
class_name Level_2


func _init():
	ID = 2
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)
	

static func create_for_cfg() -> void:
	var resource = "res://Game/Level/Level_2/Level_2.tscn"
	var texture = "res://Game/Level/assets/slides/track-02.png"
	var num_win = 7
	var init_time_level = 30
	var price = 10
	var issue: = "Around people! Don't run into them and collect the %s hourgrass"
	var res := GameData.track_cfg.create(2, 1, issue, resource, texture, num_win, init_time_level, price)
	if res != OK:
		printerr("ERROR: Level_2 create_for_cfg")
