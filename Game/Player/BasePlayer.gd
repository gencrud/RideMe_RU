extends Actor
class_name BasePlayer

var player_bike = PlayerData.player_bike

var max_speed: float = player_bike.max_speed
var max_height_jump: float = player_bike.max_height_jump
var power: float = player_bike.power
var max_power: float = player_bike.max_power

var acceleration = Vector2.ZERO
var friction = -0.2
var drag = -0.0001

onready var GUI: CanvasLayer = get_node(PathData.PATH_GUI)
onready var GameScreen: Control = get_node(PathData.PATH_GAME_SCREEN_PAUSE)
onready var SpeedBar: HBoxContainer = get_node(PathData.PATH_SPEED_BAR)
onready var PowerBar: HBoxContainer = get_node(PathData.PATH_POWER_BAR)
onready var JumpBtn: TouchScreenButton = get_node(PathData.PATH_JUMP_BTN)
onready var GoBtn: TouchScreenButton = get_node(PathData.PATH_GO_BTN)
onready var StopBtn: TouchScreenButton = get_node(PathData.PATH_STOP_BTN)
onready var anim_player: AnimationPlayer = $AnimationPlayer


# The current speed as `x` and the max-power of jump as `y`


func calculate_friction() -> Vector2:
	var len_velocity := _velocity.length()
	if len_velocity < 5: 
		_velocity = Vector2.ZERO
		
	var friction_force = _velocity * friction
	var drag_force = _velocity * len_velocity * drag
	acceleration += drag_force + friction_force
	return acceleration


"""
func calculate_steering(delta) -> Vector2:
	var rear_wheel = position - transform.x
	var front_wheel = position + transform.x
	var new_heading = (front_wheel - rear_wheel).normalized()
	var d = new_heading.dot(_velocity.normalized())
	if d > 0:
		_velocity = _velocity.linear_interpolate(new_heading * _velocity.length(), drag)
	# if d < 0:		_velocity = -new_heading * min(_velocity.length(), max_speed / 2)
	return _velocity
"""


func calculate_move_velocity(delta: float) -> Vector2:
	var direction := get_direction()

	var is_jump_interrupted := Input.is_action_just_released("ui_select") and _velocity.y < 0.0
	
	_velocity += acceleration * delta
	_velocity.y += gravity + delta
	
	# Jump
	if direction.y == -1.0:
		_velocity.y = direction.y * (max_height_jump + power*0.4 + speed.x*0.3)
		
	if is_jump_interrupted:
		_velocity.y = 0.0
	
	# When climb or descent
	if is_on_floor() and direction.x == 1: 
		if rotation < -0.2:
			_velocity.x -= get_floor_angle() * 10
		elif rotation > 0.2:
			_velocity.x += get_floor_angle() * 10

		if rotation > -0.01 and rotation < 0.01:
			_velocity.x = max_value(_velocity.x, max_speed)
		
	return _velocity


# setters

func set_power(val):
	power = positive_max_value(val, max_power)	
	if PowerBar:
		PowerBar.set_progress_player()


func set_speed(val_x = null):
	if val_x:
		speed.x = val_x
	if SpeedBar:
		SpeedBar.set_progress_player()


func set_height_jump(val_y = null):
	if val_y:
		_velocity.y = max_value(val_y, max_height_jump * 2)


# Extra methods

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-1.0 if Input.is_action_just_pressed("ui_select") and is_on_floor() else 0.0
	)


func max_value(value, max_value):
	if value is Vector2:
		value = value.x
	return max_value if value > max_value else value


func positive_max_value(value, max_value):
	return 0 if value < 0 else max_value(value, max_value)
