extends Node2D 
class_name Game

onready var player: Player = $Player
onready var Time: VBoxContainer = $GUI.get_node("Canvas/HBoxContainer/Time")


func _ready() -> void:
	var track = GameData.current_track
	add_child(track)
	PlayerData.reset_progress()
	
	# -- Add music of level
	if GameData.current_level.id == 1:
		$Player/Music.set_stream(load("res://media/track-0.wav"))
	elif GameData.current_level.id == 2:
		$Player/Music.set_stream(load("res://media/level_city.wav"))
	
	$Player/Music.autoplay = true
	$Player/Music.play()


func _process(delta) -> void:
	Time.start(delta, player)


func _on_Music_finished():
	if not $Player/Music.is_playing():
		$Player/Music.play()
