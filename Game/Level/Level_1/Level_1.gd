extends Level_0
class_name Level_1


func _init():
	ID = 1
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)


func _ready():
	var sky: Sprite = get_parent().get_node('Background/ParallaxSky/sky')
	sky.modulate = Color('#e6e588')


static func create_for_cfg() -> void:
	var resource = "res://Game/Level/Level_1/Level_1.tscn"
	var texture = "res://Game/Level/assets/slides/track-01.png"
	var num_win = 6
	var init_time_level = 25
	var price = 2
	var issue: = "Heat. Collect the %s hourgrass to see the finish"
	
	var res := GameData.track_cfg.create(1, 1, issue, resource, texture, num_win, init_time_level, price)
	if res != OK:
		printerr("ERROR: Level_1 create_for_cfg")
