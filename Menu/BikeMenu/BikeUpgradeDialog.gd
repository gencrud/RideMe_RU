extends PopupDialog

const POWER_PRICE:int = 1
const LIMIT_POWER_PRICE:int = 900
const SPEED_PRICE:int = 1
const LIMIT_SPEED_PRICE:int = 1000
const JUMP_PRICE = 1
const LIMIT_JUMP_PRICE:int = 620
const audio_btn_pressed = preload("res://media/ui/btn_pressed.wav")
const audio_btn_pay = preload("res://media/ui/btn_pay.wav")
const audio_btn_error = preload("res://media/ui/btn_error.wav")

onready var field_log: FieldLog = preload("res://components/field_log/FieldLog.gd").new()
onready var btn_no:TouchScreenButton  = $Nine/ButtonContainer/btn_no
onready var btn_yes:TouchScreenButton  = $Nine/ButtonContainer/btn_yes

onready var title: = "Качать "
onready var grid:GridContainer = $Nine/Grid
onready var power_added:Label = grid.get_node("PowerAdded")
onready var power_value:Label = grid.get_node("PowerValue")
onready var speed_added:Label = grid.get_node("SpeedAdded")
onready var speed_value:Label = grid.get_node("SpeedValue")
onready var jump_added:Label = grid.get_node("JumpAdded")
onready var jump_value:Label = grid.get_node("JumpValue")

var power_added_rms: = 0
var speed_added_rms: = 0
var jump_added_rms: = 0

var selected_rms: = 0


func _ready():
	field_log.target = $"."
	
	if PlayerData.rms < 2:
		grid.modulate.a = 0.5
		field_log.error("Need to more Rms!")


func _on_btn_power_add_pressed() -> void:
	if LIMIT_POWER_PRICE <= PlayerData.player_bike.max_power + power_added_rms:
		field_log.error_audio("Power limit reached!", $AudioStreamPlayer2D, audio_btn_error)
		return
		
	if on_btn_added(POWER_PRICE):
		power_added_rms += POWER_PRICE
		power_added.set_text("+" + str(power_added_rms))


func _on_btn_power_del_pressed() -> void:
	if on_btn_del(POWER_PRICE) and power_added_rms > 0:
		power_added_rms -= POWER_PRICE
		var _char = "+" if power_added_rms > 0 else "-"
		power_added.set_text(_char + str(power_added_rms))


func _on_btn_power_add_released() -> void:
	grid.modulate.a = 1


func _on_btn_power_del_released() -> void:
	grid.modulate.a = 1


func _on_btn_speed_add_pressed() -> void:
	if LIMIT_SPEED_PRICE <= PlayerData.player_bike.max_speed + speed_added_rms:
		field_log.error_audio("Speed limit reached!", $AudioStreamPlayer2D, audio_btn_error)
		return
		
	if on_btn_added(SPEED_PRICE):
		speed_added_rms += SPEED_PRICE
		speed_added.set_text("+" + str(speed_added_rms))


func _on_btn_speed_add_released() -> void:
	grid.modulate.a = 1


func _on_btn_speed_del_pressed() -> void:
	if on_btn_del(SPEED_PRICE) and speed_added_rms > 0:
		speed_added_rms -= SPEED_PRICE
		var _char = "+" if speed_added_rms > 0 else ""
		speed_added.set_text(_char + str(speed_added_rms))


func _on_btn_speed_del_released() -> void:
	grid.modulate.a = 1


func _on_btn_jump_add_pressed() -> void:
	if LIMIT_JUMP_PRICE <= PlayerData.player_bike.max_height_jump + jump_added_rms:
		field_log.error_audio("Jump limit reached!", $AudioStreamPlayer2D, audio_btn_error)
		return
		
	if on_btn_added(JUMP_PRICE):
		jump_added_rms += JUMP_PRICE
		jump_added.set_text("+" + str(jump_added_rms))


func _on_btn_jump_del_pressed() -> void:
	if on_btn_del(JUMP_PRICE) and jump_added_rms > 0:
		jump_added_rms -= JUMP_PRICE
		var _char = "+" if jump_added_rms > 0 else ""
		jump_added.set_text(_char + str(jump_added_rms))


func _on_btn_jump_add_released() -> void:
	grid.modulate.a = 1


func _on_btn_jump_del_released() -> void:
	grid.modulate.a = 1


func _on_btn_no_pressed() -> void:
	btn_no.modulate.a = 0.1
	
	selected_rms = 0
	power_added_rms = 0
	speed_added_rms = 0
	jump_added_rms = 0
	
	$AudioStreamPlayer2D.set_stream(audio_btn_pressed)
	$AudioStreamPlayer2D.play()
	
	if is_visible(): 
		yield(get_tree().create_timer(0.4), "timeout")
		hide()


func _on_btn_yes_pressed():
	btn_yes.modulate.a = 0.1
	$AudioStreamPlayer2D.set_stream(audio_btn_pressed)
		
	if is_visible(): 
		# Upgrade bike's parameters
		if PlayerData.rms < selected_rms:
			# var error_en = "Need to more Rms!"
			var error = "Нужно больше RM'ок!"
			field_log.error(error)
			$AudioStreamPlayer2D.set_stream(audio_btn_error)
			
		elif selected_rms > 0:
			var empty_bike: Node = load("res://Game/Bike/EmptyBike.gd").new()
			empty_bike.upgrade_bike_parameters(
				selected_rms,
				power_value, power_added_rms,
				speed_value, speed_added_rms,
				jump_value, jump_added_rms
			)
			
			# var success_en = "Bike parameters updated successfully!"
			var success = "Параметры велосипеда успешно обновлены!"
			field_log.success(success)
			$AudioStreamPlayer2D.set_stream(audio_btn_pay)
		
		$AudioStreamPlayer2D.play()
		yield(get_tree().create_timer(field_log.TIMEOUT_CLEAR), "timeout")
		var res := get_tree().reload_current_scene()
		
		if res != OK: 
			printerr("ERROR: " + str(self) + " " + str(res) + "_on_btn_yes_pressed and reload_current_scene")


func open(player_bike: Node) -> void:
	popup()  # show()

	if player_bike:
		title += player_bike.title
		find_node("Title").set_text(title)

		power_value.set_text(str(player_bike.max_power))
		speed_value.set_text(str(player_bike.max_speed))
		jump_value.set_text(str(player_bike.max_height_jump))
		
	#popup_centered()


# func set_rm_counter() -> void:	rm_counter.set_text(str(PlayerData.rms) + " / " + str(selected_rms))


func on_btn_added(price) -> bool:
	field_log.clear()
	grid.modulate.a = 0.5
	
	if PlayerData.rms > selected_rms + price:
		selected_rms += price
		# set_rm_counter()
		$AudioStreamPlayer2D.set_stream(audio_btn_pressed)
		$AudioStreamPlayer2D.play()
		return true
	else:
		# var error_en = "Need to more Rms!"
		var error = "Нужно больше RM'ок!"
		field_log.error_audio(error, $AudioStreamPlayer2D, audio_btn_error)
		return false
		

func on_btn_del(price) -> bool:
	field_log.clear()
	grid.modulate.a = 0.5
	
	if selected_rms - price >= 0:
		selected_rms -= price
		# set_rm_counter()
		$AudioStreamPlayer2D.set_stream(audio_btn_pressed)
		$AudioStreamPlayer2D.play()
		return true
	
	$AudioStreamPlayer2D.set_stream(audio_btn_error)
	$AudioStreamPlayer2D.play()
	return false
