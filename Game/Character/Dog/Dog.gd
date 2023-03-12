extends KinematicBody2D

const SPEED_JUMP_ATTACK: float = 1.8
const HALF_HEIGHT_DOG: int = 18

var animate_people = load(PathData.PATH_ANIMATE_PEOPLE).new()
var die_player = load(PathData.PATH_DIE_PLAYER).new()
	
onready var player: Player = get_node("/root/Game/Player")
onready var direction: Vector2 = Vector2.ZERO
onready var is_attack: bool = false
onready var start_position: Vector2 = position


func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta):
	# Moving from player
	if player and is_attack:
		if global_position.y + HALF_HEIGHT_DOG < start_position.y:
			global_position.y = start_position.y
		
		direction = (player.global_position - global_position).normalized()
		direction = direction * (SPEED_JUMP_ATTACK + delta)
	
		var collision := move_and_collide(direction)
		if collision and collision.collider == player:
			move_and_attack()
			

	
func _on_MotionDetecter_body_entered(body: Player):
	if body != self and body == player:
		set_is_attack(true)
		


func _on_MotionDetecter_body_exited(body: Player):
	if body != self and body == player:
		set_is_attack(false)


func set_is_attack(val: bool) -> void:
	is_attack = val
	$Sprite.flip_h = player.position.x < position.x
	
	if is_attack:
		$Audio.play()
		$Sprite.play("attack")
	else:
		$Audio.stop()
		$Sprite.play("wait")


func move_and_attack():
	position.x += HALF_HEIGHT_DOG * 10
	position.y += HALF_HEIGHT_DOG
	
	animate_people.do_collision(player.anim_player, player)
	player.power -= 20
	die_player.from_bitten_by_dog(player)
	
	set_is_attack(false)
