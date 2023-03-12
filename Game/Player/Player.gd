extends BasePlayer
class_name Player

# the max height of a stopm with road area to broken bike
const HEIGHT_STOPM_ROAD := 8989.0

# const DIVISION_MASS := 10.0
# var mass: int = 40

var is_jumping := false
var align_speed := 0.2

var audio_go = preload("res://media/move/go.wav")
var audio_relax = preload("res://media/move/relax.wav")
var audio_stop = preload("res://media/move/stop.wav")
var audio_jump = preload("res://media/move/jump.wav")
var audio_broke = preload("res://media/move/broken.wav")
var audio_colected = preload("res://media/move/colected.wav")

onready var current_animation_list:= [
	PlayerData.ANIMATION_COLLISION, 
	PlayerData.ANIMATION_DANGER, 
	PlayerData.ANIMATION_SUCCESS
]

func _ready() -> void:
	$Sprite.texture = PlayerData.player_bike.texture
	modulate = Color(1, 1, 1)
	$AudioMove.volume_db = 1


func detect_landing_animation(current_animation_name: String) -> String:
	if not is_on_floor():
		current_animation_name = "landing"
	return current_animation_name


func get_input(delta: float) -> void:
	var animation_name = "undefined"
	var has_broke: bool = $AudioMove.stream and $AudioMove.stream.resource_path.get_file().get_basename() == "broken"
	var has_colected: bool = $AudioMove.stream and $AudioMove.stream.resource_path.get_file().get_basename() == "colected"
	
	acceleration = Vector2.ZERO
	
	# Move right
	if Input.is_action_just_pressed("ui_right"):
		animation_name = detect_landing_animation("go")
		$AudioMove.set_stream(audio_go)
		# if $AudioMove.playing == false:			$AudioMove.play()
	elif Input.is_action_pressed("ui_right"):
		animation_name = detect_landing_animation("go")
		GoBtn.on_go_process(delta, animation_name)
		if $AudioMove.playing == false:
			$AudioMove.play()
	elif Input.is_action_just_released("ui_right"):
		animation_name = detect_landing_animation("relax")
		GoBtn.on_relax_process(delta)
		if not has_colected or not has_colected:
			$AudioMove.set_stream(audio_relax)
			$AudioMove.play()
	# Move backward
	elif Input.is_action_just_pressed("ui_left"):
		animation_name = detect_landing_animation("stop")
		$AudioMove.set_stream(audio_stop)
		$AudioMove.play()
	elif Input.is_action_pressed("ui_left"):
		animation_name = detect_landing_animation("stop")
		StopBtn.on_stop_process(delta)
	elif Input.is_action_just_released("ui_left"):
		animation_name = detect_landing_animation("relax")
		StopBtn.on_stop_released(delta)
	# Idle or relax 
	elif not is_jumping:
		if _velocity.x < 10 and _velocity.x > -10:
			animation_name = detect_landing_animation("wait")
			GoBtn.on_wait_process(delta, animation_name)
		else:
			animation_name = detect_landing_animation("relax")
			GoBtn.on_relax_process(delta, animation_name)

	# Move jump up / landing
	if Input.is_action_just_pressed("ui_select"):
		animation_name = detect_landing_animation("landing")
		if not has_broke or not has_colected:
			$AudioMove.set_stream(audio_jump)
	elif Input.is_action_pressed("ui_select"):
		animation_name = detect_landing_animation("landing")
		JumpBtn.on_jump_process(delta, animation_name)
		if not has_broke or not has_colected:
			if $AudioMove.playing == false:
				$AudioMove.play()
	elif Input.is_action_just_released("ui_select"):
		animation_name = detect_landing_animation("landing")
		JumpBtn.on_landing_process(delta, animation_name)
		if not has_colected or not has_colected:
			$AudioMove.set_stream(audio_go)
		$AudioMove.play()
	

# Processes

func _process(delta: float) -> void:
	set_speed(_velocity.x)

	if not anim_player.current_animation in current_animation_list:
		modulate = Color.white

	# prepare to die
	if PlayerData.time_level < 5:
		if anim_player.current_animation != PlayerData.ANIMATION_COLLISION:
			anim_player.stop()
		anim_player.play(PlayerData.ANIMATION_COLLISION)
		
	if position.y > HEIGHT_STOPM_ROAD:
		var die_player = load(PathData.PATH_DIE_PLAYER).new()
		die_player.from_fell(self)


func _physics_process(delta: float) -> void:
	get_input(delta)
	_calc_velocity(delta)
	
	if is_on_floor():
		is_jumping = Input.is_action_just_pressed("ui_select")
		rotation = lerp(rotation, get_floor_normal().angle() + PI/2, align_speed)


func _on_CollisionDetector_body_entered(body: Node2D) -> void:
	if 'MovingPlatform' in body.name:
		body.has_move_up = false
		# body.position.y += mass / DIVISION_MASS


func _on_CollisionDetector_body_exited(body: Node2D) -> void:
	if 'MovingPlatform' in body.name:
		body.has_move_up = true
		# body.position.y -= mass / DIVISION_MASS


func _calc_velocity(delta: float) -> void:
	var snap: Vector2 = Vector2.DOWN * 128 if !is_jumping else Vector2.ZERO
	
	acceleration = calculate_friction()
	# _velocity = calculate_steering(delta)
	_velocity = calculate_move_velocity(delta)
	_velocity.y = move_and_slide_with_snap(_velocity, snap, FLOOR_NORMAL, true).y
