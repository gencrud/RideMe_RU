extends BaseProgressDialog
class_name LevelProgressDialog

const RES_LEVEL_PROGRESS_DIALOG_ROWS = "res://Menu/LevelMenu/LevelProgressDialog/rows/"

onready var table: VBoxContainer = $Nine/TableContainer


func _ready():
	._ready()
	
	set_title(GameData.current_track)
	
	clean_table()
	fill_table()


func _on_btn_yes_pressed():
	._on_btn_yes_pressed()
	
	if has_node("/root/LevelMenu") and not GameData.current_level.empty() and GameData.current_track:
		get_node("/root/LevelMenu").selected_node = GameData.current_track
		set_title(GameData.current_track)
	
# work on table

func clean_table() -> void:
	if is_instance_valid(table) and table.get_child_count() > 0:
		for row in table.get_children():
			table.remove_child(row)
			row.queue_free()


func fill_table() -> void:
	for track in GameData.track_cfg.get_tracks(GameData.current_level.id):
		if LevelTrackStates.PASSED == track.state:
			add_passed_row_to_table(track)
		elif LevelTrackStates.FAIL == track.state:
			add_fail_row_to_table(track)
		elif LevelTrackStates.ACTIVE == track.state:
			add_active_row_to_table(track)
		elif LevelTrackStates.PAY == track.state:
			add_pay_row_to_table(track)


func add_passed_row_to_table(track: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PassedRow.tscn"), track)


func add_active_row_to_table(track: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "ActiveRow.tscn"), track)


func add_pay_row_to_table(track: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "PayRow.tscn"), track)


func add_fail_row_to_table(track: Dictionary) -> void:
	add_row_to_table(load(RES_LEVEL_PROGRESS_DIALOG_ROWS + "FailRow.tscn"), track)
	

func add_row_to_table(resource: Resource, track: Dictionary) -> void:
	if is_instance_valid(table):
		var row: ActiveRow = resource.instance()
		row.init_track(track)
		table.add_child(row)


func set_title(track: Node2D) -> void:
	if not track and GameData.current_level:
		var passed_tracks := GameData.track_cfg.get_passed_tracks(GameData.current_level.id)
		if not passed_tracks.empty():
			var passed_track = passed_tracks[0]
			
			track = load(passed_track.resource).instance()
			GameData.current_track = track
		
	.set_title(track)
	
	if not GameData.current_level.passed_at.empty():
		$Nine/Title.set_text("%s passed!" % [track.title])
		$Nine/Title.modulate = Color(0.1, 0.5, 0.1) # GREEN
		
		$Completed.visible = true
		
		# Demo mode
		# $PopupCompleted.popup()
