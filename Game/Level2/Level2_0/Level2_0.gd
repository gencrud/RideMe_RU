extends Level_0
class_name Level2_0

onready var _custom_background: Resource = preload("res://Game/Level2/Background/Background.tscn")
onready var custom_background: ParallaxBackground = _custom_background.instance()
onready var root := get_parent()
onready var bd: ParallaxBackground = root.get_node("Background")


func _init() -> void:
	ID = 4
	var section: = track_cfg.get_section(ID)
	init_level_track(section, ID)

	
func _ready() -> void:
	apply_custom_background()
	init_start_position()
	

func apply_custom_background() -> void:
	root.remove_child(bd)
	bd.call_deferred("free")
	root.add_child(custom_background)
	custom_background.visible = false


static func create_for_cfg() -> void:
	var level_id = 2
	var track_id = 4
	var resource = "res://Game/Level2/Level2_0/Level2_0.tscn"
	var texture = "res://Game/Level2/assets/slides/track-2_0.png"
	var num_win = 9
	var init_time_level = 25
	var price = 20
	# var issue_en = "City dogs. Collect %s of the hourglass as quickly as possible to reach the finish line"
	var issue = "Городские собаки. Соберите %s песочных часов как можно быстрее, чтобы добраться до финиша"
	var res := GameData.track_cfg.create(track_id, level_id, issue, resource, texture, num_win, init_time_level, price)
	# assert(res != OK, "ERROR: Level2_0 create_for_cfg")
