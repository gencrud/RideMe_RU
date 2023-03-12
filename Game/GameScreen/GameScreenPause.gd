extends Control
class_name GameScreenPause

onready var sceen_tree := get_tree()
onready var pause_rect: ColorRect = get_node("PauseRect")
onready var title: Label = get_node("PauseRect/Title")
onready var container_btn: VBoxContainer = get_node("PauseRect/Container")
onready var player: KinematicBody2D = get_node(PathData.PATH_PLAYER)

	
var _counter: int = 3
var paused: = true setget set_paused


func _ready():
	set_paused(true)
	title.visible = false
	container_btn.visible = false
		
	var next_level_btn: NextLevelBtn = pause_rect.get_node("Container/NextLevelBtn")
	next_level_btn.visible = false

	$Timer.start()
	$TimeToStart.set_text(str(_counter))
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		sceen_tree.set_input_as_handled()


func set_paused(value: bool) -> void:
	paused = value
	sceen_tree.paused = value
	pause_rect.visible = value


func _on_Timer_timeout() -> void:
	var background: ParallaxBackground = get_node(PathData.PATH_GAME + "/Background")
	
	if is_instance_valid(GameData.current_track):
		if _counter == 0:
			$Timer.stop()
			$Timer.queue_free()
			$TimeToStart.queue_free()
			
		elif _counter == 1:
			set_paused(false)
			title.visible = true
			container_btn.visible = true
			
			background.visible = is_instance_valid(background)
			pause_rect.get_node("InnerSky").queue_free()
			
			$TimeToStart.get_font("font").size = 64
			
			var text = "Go go go\r\n%s: %d" % [GameData.current_level.title, GameData.current_track.ID]
			$TimeToStart.set_text(text)
			
			_counter -= 1
		else:
			_counter -= 1
			$TimeToStart.set_text(str(_counter))


