class_name AnimatePeople

const COLLISION_SPEED_X:int = 200
const COLLISION_ANIMATE: String = "collision"


func do_collision(animation:AnimationPlayer, player: Player,  target: Node = null) -> void:
	play_collision(animation)
	player_hit_person(player)
	do_bound(player, target)


func play_collision(animation: AnimationPlayer) -> void:
	if animation:
		animation.play(COLLISION_ANIMATE)


func hit_player(player: Player, power_hit: int = 1) -> void:
	player._velocity.x -= player.speed.x + COLLISION_SPEED_X
	player.set_speed(player._velocity.x)
	player.anim_player.play(COLLISION_ANIMATE)
	PlayerData.lives -= power_hit


func player_hit_person(player: Player) -> void:
	hit_player(player, 0)
	if PlayerData.lives > 25:
		PlayerData.lives -= 40
	else:
		PlayerData.lives = 0
		player.anim_player.get_animation(COLLISION_ANIMATE).set_loop(true)
		die_from_person(player)


func do_bound(player: Player, target: Node) -> void:
	# Can be null if bounce is not needed
	if target:
		var has_passed:bool = target.global_position > player.global_position
		target.position.x += COLLISION_SPEED_X if has_passed else -COLLISION_SPEED_X
		player.position.x += -COLLISION_SPEED_X if has_passed else COLLISION_SPEED_X


func die_from_person(player: Player) -> void:
	var die = load(PathData.PATH_DIE_PLAYER).new()
	die.from_hir_person(player)
