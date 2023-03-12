extends Node2D
class_name CloudMove

const SPEED = 50
const SCALE_X = 1

export(int) var speed
export(float) var scale_x


func _ready():
	if not speed:
		speed = SPEED
	if not scale_x:
		scale_x = SCALE_X
		
	$Path2D/PathFollow2D/Sprite.scale = Vector2(scale_x, scale_x)


func _process(delta):
	$Path2D/PathFollow2D.offset -= speed * delta
