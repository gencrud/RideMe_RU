extends Level_0
class_name Level2_2

onready var _custom_background: Resource = preload("res://Game/Level2/Background/Background.tscn")
onready var custom_background: ParallaxBackground = _custom_background.instance()
onready var root := get_parent()
onready var bd: ParallaxBackground = root.get_node("Background")


func _init() -> void:
	ID = 6  # first track in level
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)


func _ready() -> void:
	apply_custom_background()

	var sky: Sprite = get_parent().get_node('Background/ParallaxSky/Sky')
	sky.modulate = Color('#98c3dc')


func apply_custom_background() -> void:
	root.remove_child(bd)
	bd.call_deferred("free")
	root.add_child(custom_background)


static func create_for_cfg() -> void:
	var level_id = 2
	var track_id = 6
	var resource = "res://Game/Level2/Level2_2/Level2_2.tscn"
	var texture = "res://Game/Level2/assets/slides/track-2_2.png"
	var num_win = 6
	var init_time_level = 40
	var price = 10
	var issue = "Сity jumps. Collect the %s hourgrass to see the finish"
	
	var res := GameData.track_cfg.create(track_id, level_id, issue, resource, texture, num_win, init_time_level, price)
	if res != OK: 
		printerr("ERROR: Level2_2 create_for_cfg")
