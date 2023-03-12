extends TouchScreenButton
class_name ControlBtn

const POWER_GO := 10.0
const POWER_RELAX := 4.0
const POWER_WAIT := 2.0
const MODULATE_A_OFF = 1
const MODULATE_A_ON = 0.7

var calc_power: float
var calc_speed: float

onready var player: Player = get_node(PathData.PATH_PLAYER)
onready var anim_player: AnimationPlayer = player.get_node("./AnimationPlayer")


func on_pressed() -> void:
	modulate.a = MODULATE_A_ON
	Input.action_press(action)
	

func on_released() -> void:
	modulate.a = MODULATE_A_OFF
	Input.action_release(action)
	

func _ready() -> void:
	modulate.a = MODULATE_A_OFF
	connect("pressed", self, "on_pressed")
	connect("released", self, "on_released")
	# var res := ... 
	# assert(not res, "ERROR: _ready connect on_pressed")
	# res = ... assert(not res, "ERROR: _ready connect on_released")


func on_wait_process(dt: float, animation_name: String = "wait"):
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
	set_wait_power(dt)


func set_wait_power(dt: float) -> void:
	calc_power = player.power + (dt * player.max_power / POWER_WAIT)
	player.set_power(calc_power)


func detect_collision_animation(animation_name: String) -> String:
	if anim_player.is_playing():
		if anim_player.current_animation == PlayerData.ANIMATION_COLLISION:
			return PlayerData.ANIMATION_COLLISION
		elif anim_player.current_animation == PlayerData.ANIMATION_SUCCESS:
			return PlayerData.ANIMATION_SUCCESS

	return animation_name


"""
	signal double_click_pressed
	signal double_click_released

	var _double_speed := 1000 * 0.25
	var _last_click := 0.0

	func double_click_detect() -> bool:
		var new_click: = OS.get_ticks_msec()
		if new_click - _last_click <= _double_speed:
			return true
			
		_last_click = new_click
		return false

	func on_double_click_pressed() -> void:
		Input.action_press("ui_select")

	func on_double_click_released() -> void:
		Input.action_release("ui_select")

	func _ready():
		...
		connect("double_click_released", self, "on_double_click_released")
"""
