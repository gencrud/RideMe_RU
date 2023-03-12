extends HBoxContainer
class_name ActiveRow   # via BaseClass of the Rows

const audio_btn_pressed = preload("res://media/ui/btn_pressed.wav")
const audio_btn_run = preload("res://media/ui/btn_run.wav")
const audio_btn_pay = preload("res://media/ui/btn_pay.wav")
const audio_btn_error = preload("res://media/ui/btn_error.wav")

var _track: Dictionary
var track: Level_0


func _on_PlayBtn_pressed() -> void:
	if has_node("/root/LevelMenu") and not _track.empty():
		GameData.current_track = get_track_resource()
		get_node("/root/LevelMenu").selected_node = GameData.current_track


func set_title() -> void:
	track = get_track_resource()
	$Title.set_text("%d/%d. %s" % [_track.level_id, _track.id, track.init_issue()])


func set_price() -> void:
	$Price.set_text("$")


func init_track(track_dict: Dictionary) -> void:
	_track = track_dict
	set_title()
	set_price()


func get_track_resource() -> Level_0:
	if not track and not _track.empty():
		track = load(_track.resource).instance()
	return track
	

