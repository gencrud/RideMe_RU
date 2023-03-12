extends GoBtn
class_name StopBtn

# onready var has_backwards_riding: bool = false
# onready var stop_value: float = player.max_speed
# onready var allow_back_speed = -stop_value / 2


func on_stop_process(dt: float, animation_name: String = "stop") -> void:
	on_pressed()
	
	animation_name = detect_collision_animation(animation_name)
	anim_player.play(animation_name)
		
	if player.speed.x > -(player.max_speed / 2):
		player.acceleration = -player.transform.x * player.power
		set_relax_power(dt)
		
	# has_backwards_riding = player.speed.x < 0
	# if player.speed.x > allow_back_speed and not has_backwards_riding: player.set_speed(player.speed.x - dt * stop_value)
	# else:		player.set_speed(allow_back_speed)
	

func on_stop_released(dt: float) -> void:
	on_released()
