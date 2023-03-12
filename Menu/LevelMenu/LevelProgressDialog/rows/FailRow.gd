extends ActiveRow
class_name FailRow


func _ready() -> void:
	$PlayBtn/Label.set_text("replay")
	set_time()


func set_time() -> void:
	var _track_section: = GameData.track_cfg.get_section(_track.id)
	var player_track_section: = _track_section.replace(GameData.track_cfg.prefix, GameData.player_track_cfg.prefix)
	var best_time_at = GameData.player_track_cfg.get_best_time_at(player_track_section)

	if best_time_at:
		$Time.set_text(best_time_at.replace(" ", ""))
