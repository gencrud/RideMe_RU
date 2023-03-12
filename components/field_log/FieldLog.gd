extends CanvasLayer
class_name FieldLog

const NAME: String = "FieldLog"
const TIMEOUT_CLEAR: int = 1

var field_log: FieldLog
var target: Node


func success(message: String):
	var field_log_instanse: FieldLog = load("res://components/field_log/FieldLogSuccess.tscn").instance()
	show_hide(message, field_log_instanse)


func error(message: String):
	var field_log_instanse: FieldLog = load("res://components/field_log/FieldLogError.tscn").instance()
	show_hide(message, field_log_instanse)


func error_audio(message: String, audio_stream: AudioStreamPlayer2D, track: Resource) -> void:
	clear()
	error(message)
	audio_stream.set_stream(track)
	audio_stream.play()


func info(message: String):
	var field_log_instanse: FieldLog = load("res://components/field_log/FieldLog.tscn").instance()
	show_hide(message, field_log_instanse)


func show_hide(message: String, instanse: FieldLog) -> void:
	instanse.get_node("Label").set_text(message)
	target.add_child(instanse)
	yield(target.get_tree().create_timer(TIMEOUT_CLEAR), "timeout")
	if is_instance_valid(target):	
		target.remove_child(instanse)


func get_or_create() -> FieldLog:
	if not target:
		push_error("Need to init `target` of FieldLog's label")
		raise()

	for child in target.get_children():
		if NAME in child.name:
			field_log = child
			break
			
	return field_log


func clear() -> void:
	field_log = get_or_create()
	if is_instance_valid(field_log):
		target.remove_child(field_log)


"""
const WHITE = Color(1, 1, 1)
const GREEN = Color(0.1, 0.5, 0.1)
const RED = Color(0.8, 0, 0)
const FONT_PATH = "res://Game/GUI/assets/font/Comfortaa-Bold.ttf"

func create() -> Label:	
	field_log = Label.new()	
	field_log.name = NAME	
	set_dynamic_font(field_log)	
	return field_log

func set_dynamic_font(label: Label) -> void:
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load(FONT_PATH)
	dynamic_font.size = 24
	label.set("custom_fonts/font", dynamic_font)
"""
