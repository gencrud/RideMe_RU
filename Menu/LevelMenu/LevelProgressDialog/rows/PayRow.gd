extends ActiveRow
class_name PayRow

export (bool) var is_flicker
onready var field_log: FieldLog = preload("res://components/field_log/FieldLog.gd").new()


func _ready():
	field_log.target = $Title
	
	if PlayerData.rms < int($Price.text.replace("rm", "")):
		$PayBtn.modulate.a = 0.4
		$PayBtn.disabled = true
	
	is_flicker = PlayerData.rms/2 > _track.price
	if is_flicker:
		anim_flicker()


func _on_PayBtn_button_down():
	if PlayerData.rms < _track.price:
		$PayBtn/AudioStreamPlayer2D.set_stream(audio_btn_error)
	else:
		$PayBtn/AudioStreamPlayer2D.set_stream(audio_btn_pay)
	$PayBtn/AudioStreamPlayer2D.play()


func _on_PayBtn_pressed():
	if not _track:
		field_log.error("You have not an initial track")
		return
	
	var track_section: = GameData.track_cfg.get_section(_track.id)
	var player_track_section: = track_section.replace(GameData.track_cfg.prefix, GameData.player_track_cfg.prefix)
	
	if GameData.player_track_cfg.config.has_section(player_track_section):
		var message = "You have already paid for this track %s" % player_track_section
		field_log.info(message)
		return
	
	if PlayerData.rms < _track.price:
		field_log.error("Need to more Rms!")
		return

	PlayerData.save_rms(PlayerData.rms - _track.price)
	create_player_track(track_section)
	field_log.success("The %s track was paid!" % player_track_section)
	
	var path_popup = "/root/LevelMenu/LevelProgressDialog"
	if has_node(path_popup):
		var level_popup: LevelProgressDialog = get_node(path_popup)
		level_popup._on_btn_yes_pressed()


func set_price() -> void:

	$Price.set_text("%s rm" % [str(_track.price)])

func set_time() -> void:
	$Time.set_text("..:..")


func create_player_track(track_section:String) -> void:
	var track_resource := GameData.track_cfg.get_resource(track_section)
	var player_track_section := track_section.replace(GameData.track_cfg.prefix, GameData.player_track_cfg.prefix)
	
	GameData.player_track_cfg.create(track_section, player_track_section)
	GameData.track_cfg.set_state(track_section, LevelTrackStates.ACTIVE)
	
	GameData.current_track = load(track_resource).instance()
	GameData.current_track.resource = track_resource


func anim_flicker() -> void:
	is_flicker = true
	$PayBtn/AnimPlayer.play("flicker")
