extends Level_0
class_name Level_3


func _init():
	ID = 3
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)
	

func _ready():
	do_rain()


func do_rain():
	var sky: Sprite = get_parent().get_node('Background/ParallaxSky/sky')
	sky.modulate = Color('#98c3dc')


static func create_for_cfg() -> void:
	var resource = "res://Game/Level/Level_3/Level_3.tscn"
	var texture = "res://Game/Level/assets/slides/track-03.png"
	var num_win = 8
	var init_time_level = 18
	var price = 20
	# var issue_en: = "Night road. Collect the %s hourgrass as soon as possible"
	var issue = "Night road. Collect %s of the hourglass as soon as possible"
	var res := GameData.track_cfg.create(3, 1, issue, resource, texture, num_win, init_time_level, price)
	if res != OK:
		print("ERROR: Level_3 create_for_cfg")
