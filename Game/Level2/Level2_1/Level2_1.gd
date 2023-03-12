extends Level_0
class_name Level2_1

onready var _custom_background: Resource = load("res://Game/Level2/Background/Background.tscn")
onready var custom_background: ParallaxBackground = _custom_background.instance()
onready var root := get_parent()
onready var bd: ParallaxBackground = root.get_node("Background")


func _init() -> void:
	ID = 5  # first track in level
	var section: = track_cfg.get_section(ID)
	.init_level_track(section, ID)


func _ready() -> void:
	apply_custom_background()
	
	var sky: Sprite = get_parent().get_node('Background/ParallaxSky/Sky')
	sky.modulate = Color('#e6e588')


func apply_custom_background() -> void:
	root.remove_child(bd)
	bd.call_deferred("free")
	root.add_child(custom_background)


static func create_for_cfg() -> void:
	var level_id = 2
	var track_id = 5
	var resource = "res://Game/Level2/Level2_1/Level2_1.tscn"
	var texture = "res://Game/Level2/assets/slides/track-2_1.png"
	var num_win = 6
	var init_time_level = 40
	var price = 10
	# var issue_en = "Crowded road. Collect %s hourglasses. Time is limited"
	var issue = "Переполненная дорога. Соберите %s песочных часов. Время ограничено!"
	var res := GameData.track_cfg.create(track_id, level_id, issue, resource, texture, num_win, init_time_level, price)
	if res != OK:
		printerr("ERROR: Level2_1 create_for_cfg")
