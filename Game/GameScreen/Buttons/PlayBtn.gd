tool
extends Button

export(String, FILE) var level_scn: = ""


func _on_button_up() -> void:
	get_tree().change_scene(level_scn)


func _get_configuration_warning() -> String:
	return "Level scene path must be set for button to work" \
		if level_scn == "" else ""
