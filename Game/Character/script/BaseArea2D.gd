extends Area2D
class_name BaseArea2D


func _on_body_entered(body):
	set_bike_parameters(body)
	
	body.get_node('AudioMove').set_stream(body.audio_stop)
	body.get_node('AudioMove').play()


func _ready() -> void:
	set_physics_process(false)


func set_bike_parameters(player: Player):
	if player._velocity.x > 100: 
		player._velocity.x -= 100
		player.set_power(player.power - 100)
