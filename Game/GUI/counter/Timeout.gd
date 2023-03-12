extends MarginContainer
class_name Timeout

onready var timer: Timer = get_node("Timer")
onready var timer_value: Label = get_node("Background/Value")
onready var player: KinematicBody2D = get_node(PathData.PATH_PLAYER)


func _ready() -> void:
	timer.start()
	timer_value.set_text(str(PlayerData.time_level))


func _physics_process(delta: float) -> void:
	# animation
	if PlayerData.time_level < 4:
		$AnimationPlayer.play(PlayerData.ANIMATION_DANGER)


func _on_Timer_timeout() -> void:
	if PlayerData.time_level == 0:
		var die_player = load(PathData.PATH_DIE_PLAYER).new()
		die_player.from_time_up(player)

	PlayerData.time_level -= 1
