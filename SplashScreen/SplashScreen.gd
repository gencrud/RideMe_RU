tool
extends TextureRect

export (String, FILE) var main_menu_tscn: = ""


func _get_configuration_warning() -> String:
	var msg: String = "Main Menu scene must be set "
	return msg if main_menu_tscn == "" else ""



func _on_Start_button_down() -> void:
	# First start game
	var player_bike_cfg: PlayerBikeCfg = load(PathData.PLAYER_BIKE_MODEL).new()
	if player_bike_cfg.first().empty():
		var option_menu: OptionMenu = load("res://Menu/OptionMenu/OptionMenu.tscn").instance()
		option_menu.reset_game_config()
