extends PopupDialog
class_name BaseProgressDialog

onready var field_log: FieldLog = preload("res://components/field_log/FieldLog.gd").new()
onready var title: String = "Прогресс: %s" 	# EN / RU VERSION
onready var btn_no:TouchScreenButton  = $Nine/ButtonContainer/btn_no
onready var btn_yes:TouchScreenButton  = $Nine/ButtonContainer/btn_yes


func _ready():
	field_log.target = $"."


# buttons' singans 

func _on_btn_no_pressed() -> void:
	btn_no.modulate.a = 0.1
	if is_visible(): 
		yield(get_tree().create_timer(0.4), "timeout")
		hide()


func _on_btn_yes_pressed():
	btn_yes.modulate.a = 0.1
	if is_visible(): 
		yield(get_tree().create_timer(0.4), "timeout")
		var res := get_tree().reload_current_scene()
		if res != OK:
			printerr("ERROR: " + str(self) + " " + str(res) + "_on_btn_pay_pressed and reload_current_scene")


# popup

func open(current_node: Node2D) -> void:
	set_title(current_node)
	popup()  # show()


# setters

func set_title(current_node: Node2D) -> void:
	if current_node:
		$Nine/Title.set_text(title % [current_node.title])
