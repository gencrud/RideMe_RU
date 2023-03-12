extends BaseBikeMenu
class_name LevelMenu

onready var btn_level_1: Button = $TextureRect/SliderContainer/Buttons/Level_1
onready var btn_level_2: Button = $TextureRect/SliderContainer/Buttons/Level_2

const RES_LEVEL_PROGRESS_DIALOG: String = "res://Menu/LevelMenu/LevelProgressDialog/LevelProgressDialog.tscn"
onready var progress_popup: Resource = preload(RES_LEVEL_PROGRESS_DIALOG)


func _ready() -> void:
	# False if all tracks of level 1 (Mountains) were passed successful!
	var section_level_1: String = GameData.level_cfg.get_section("1")
	btn_level_2.disabled = GameData.level_cfg.get_passed_at(section_level_1).empty()

	._ready()
	
	init_btn_current_node()
	
	var res = btn_refit.connect("pressed", self, "_on_btn_refit_pressed")
	# of not res:, "ERROR: LevelMenu connect _on_btn_refit_pressed")
	res = btn_pay.connect("pressed", self, "_on_btn_pay_pressed")
	# assert(not res, "ERROR: LevelMenu connect _on_btn_pay_pressed")
	
	if selected_node != null:
		btn_refit.modulate.a = 1
	
	btn_pay.modulate.a = 0.4
	if PlayerData.player_bike and GameData.current_track and not GameData.current_level.empty():
		btn_pay.modulate.a = 1
		btn_pay.type = "Run"
		btn_pay.anim_flicker()
	
	if not is_instance_valid(GameData.current_track):
		if GameData.current_level.id == 1:
			_on_Level_1_pressed()
			_on_btn_refit_pressed()
		elif GameData.current_level.id == 2:
			_on_Level_2_pressed()
			_on_btn_refit_pressed()
	elif GameData.current_track.has_passed():
		btn_refit.anim_flicker()

	# -- Demo mode
	# if $Completed.visible:
	#	var popup_completed: Popup = load("res://Menu/LevelMenu/PopupCompleted/PopupCompleted.tscn").instance()
	#	add_child(popup_completed)
	#	popup_completed.popup()
	if GameData.track_cfg.has_passed_level(1) and GameData.track_cfg.has_passed_level(2):
		var popup_completed: Popup = load("res://Menu/LevelMenu/PopupCompleted/PopupFinished.tscn").instance()
		add_child(popup_completed)
		popup_completed.popup()


func _on_btn_pay_pressed() -> void:
	var main_menu: MainMenu = load(PathData.RES_MAIN_MENU_TSCN).instance()  
	if not main_menu.can_start_play():
		main_menu.field_log = field_log
		main_menu.field_log_start_play()
	else:
		yield(get_tree().create_timer(0.4), "timeout")
		var res := get_tree().change_scene(main_menu.game_tscn) 
		assert(not res, "ERROR: LevelMenu _on_btn_pay_pressed change_scene")


func _on_btn_refit_pressed() -> void:
	if GameData.current_level:
		var progress_popup_instance: PopupDialog = progress_popup.instance()
		var progress_popup_name = progress_popup_instance.name
		
		add_child(progress_popup_instance)
		yield(get_tree().create_timer(0.4), "timeout")
		
		if has_node(progress_popup_name) and get_node(progress_popup_name):
			progress_popup_instance.open(GameData.current_level)
	else:
		# var message_en = "Level not selected"
		var message = "Уровень не выбран"
		field_log.error(message)


# --- Levels pressed ---

func _on_Level_1_pressed() -> void:
	field_log.clear()
	set_active_or_passed_or_fail_track(1)
	
	if GameData.current_track:
		set_buttons_flat(btn_level_1)
		
		if PlayerData.player_bike:
			btn_pay.modulate.a = 1
			btn_pay.anim_flicker()

	selected_node = GameData.current_track
	init_slide(selected_node)


func _on_Level_2_pressed() -> void:
	var pk: int = 2
	
	field_log.clear()
	set_active_or_passed_or_fail_track(pk)
	
	if not btn_level_2.disabled:
		set_buttons_flat(btn_level_2)
	
	var passed_tracks: Array = GameData.track_cfg.get_passed_tracks(pk)
	var active_track: Dictionary = GameData.track_cfg.get_active_track(pk)
	
	if GameData.current_level.id == 2:
		selected_node = GameData.current_track
	# If level 2 is active AND not any paid track of level 2
	elif not btn_level_2.disabled and passed_tracks.empty() and active_track.empty():
		var option_menu: OptionMenu = load("res://Menu/OptionMenu/OptionMenu.tscn").instance()
		option_menu.create_player_track(4)  # First id track of level 2
		selected_node = GameData.current_track
		GameData.current_level = GameData.level_cfg.as_dict(GameData.level_cfg.get_section(2))

	init_slide(selected_node)


func set_active_or_passed_or_fail_track(level_id: int) -> void:
	var level_section = GameData.level_cfg.get_section(level_id)
	var track: Dictionary = GameData.track_cfg.get_active_track(level_id)
	
	var has_passed_level: bool = not GameData.level_cfg.get_passed_at(level_section).empty()
	var passed_levels: Array = GameData.track_cfg.get_passed_tracks(level_id)
	if track.empty() and has_passed_level and not passed_levels.empty():
		track = passed_levels[-1]
	
	if track.empty():
		var fail_levels: Array = GameData.track_cfg.get_fail_tracks(level_id)
		if not fail_levels.empty():
			track = fail_levels[-1]
	
	if not track.empty():
		GameData.current_track = load(track.resource).instance()
		GameData.current_level = GameData.level_cfg.as_dict(level_section)

# ---  END Level ---


func init_slide(track: Node2D) -> void:
	if track:
		.init_slide(track)
		set_menu_options(track)
		btn_refit.modulate.a = 1
		$Completed.visible = GameData.track_cfg.has_passed_level(GameData.current_level.id)


func init_btn_current_node() -> void:
	if not GameData.current_level.empty() and GameData.current_track:
		init_slide(GameData.current_track)
		btn_level_1.flat = bool(btn_level_1.name == GameData.current_level.title)
		btn_level_2.flat =  bool(btn_level_2.name == GameData.current_level.title)
		

func set_menu_options(level: Level_0) -> void:	
	if is_instance_valid(level):
		# EN VERSION
		# var level_text: String = "level: ....... %d" % [level.level_id]
		# var track_text: String = "track: .......... %d" % [level.track_id]
		# var price_text: String = "price: .................... %d" % [level.price]
		# RU VERSION
		var level_text: String = "уровень: ..................... %d" % [level.level_id]
		var track_text: String = "трасса: ...................... %d" % [level.track_id]
		var price_text: String = "цена: ........................... %d" % [level.price]
		
		menu_options.get_node('LevelIssue').set_text(level.init_issue())
		menu_options.get_node('Level').set_text(level_text)
		menu_options.get_node('Track').set_text(track_text)
		menu_options.get_node('Price').set_text(price_text)


func set_buttons_flat(btn_active: Button) -> void:
	btn_level_1.flat = bool(btn_level_1.name == btn_active.name)
	btn_level_2.flat = bool(btn_level_2.name == btn_active.name)
