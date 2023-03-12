extends "res://Game/GUI/bar/Bar.gd"

onready var _label_value: Label = get_node(PathData.PATH_POWER_BAR_COUNT_VALUE)
onready var _progress: TextureProgress = $"./Gauge"


func _ready() -> void:
	_progress.max_value = player.max_power


func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		do_or_stop_animation_danger(player.power, player.max_power)
	
	
func set_progress_player():
	_label_value.text = '%.2f' % player.power
	_progress.value = player.power