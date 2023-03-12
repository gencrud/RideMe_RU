extends MarginContainer
class_name GUI

onready var lives_value: Label = get_node(PathData.PATH_LIVES_COUNTER_VALUE)


func _ready() -> void:
	set_lives()


func set_lives():
	lives_value.text = str(PlayerData.lives)
