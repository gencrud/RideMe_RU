extends BaseBikeMenu
class_name BikeMenu

onready var empty_bike: EmptyBike = load("res://Game/Bike/EmptyBike.gd").new()
onready var sataur_bike: SataurBike = load("res://Game/Bike/SataurBike.gd").new()
onready var drawer_bike: DrawsterBike = load("res://Game/Bike/DrawsterBike.gd").new()

onready var btn_sataur: Button = $TextureRect/SliderContainer/Buttons/Sataur
onready var btn_drawster: Button = $TextureRect/SliderContainer/Buttons/Drawster

onready var bike_upgrade: Resource = preload("res://Menu/BikeMenu/BikeUpgradeDialog.tscn")


func _ready() -> void:
	._ready()
	init_btn_current_node()


func _on_Sataur_pressed() -> void:
	field_log.clear()
	set_buttons_flat(btn_sataur)
	init_slide(sataur_bike)


func _on_Drawster_pressed() -> void:
	field_log.clear()
	set_buttons_flat(btn_drawster)
	init_slide(drawer_bike)


func _on_btn_pay_button_down() -> void:
	if not PlayerData.player_bike and selected_node and PlayerData.rms > selected_node.price:
		$TextureRect/ButtonContainer/btn_pay.type = "Buy"
	else:
		$TextureRect/ButtonContainer/btn_pay.type = "Error"


func _on_btn_pay_pressed() -> void:
	# TODO: redo
	# field_log.clear
	if is_instance_valid(field_log):
		$TextureRect/Title.remove_child(field_log)
	
	if not PlayerData.player_bike:
		if selected_node and selected_node.price > 0:
			if PlayerData.rms < selected_node.price:
				# var error_en = "Need to more Rms!"
				var error = "Нужно больше RM'ок!"
				field_log.error(error)
			else:
				PlayerData.player_bike_cfg.set_bike_title(selected_node.title)
				PlayerData.player_bike_cfg.set_max_speed(selected_node.max_speed)
				PlayerData.player_bike_cfg.set_max_power(selected_node.max_power)
				PlayerData.player_bike_cfg.set_max_height_jump(selected_node.max_height_jump)
				
				PlayerData.save_rms(PlayerData.rms - selected_node.price)
				PlayerData.player_bike = selected_node
				
				btn_refit.modulate.a = 1
				btn_pay.modulate.a = 0.4
				
				btn_pay.type = "Buy"
				
				# var success_en = "Bike paid successfully"
				var success = "Байк успешно оплачен"
				field_log.success(success)
				
				yield(get_tree().create_timer(0.4), "timeout")
				var res := get_tree().reload_current_scene()
				if res != OK:
					printerr("ERROR: " + str(self) + " " + str(res) + "_on_btn_pay_pressed and reload_current_scene")
		else:
			# var message_en = "Bike not selected"
			var message = "Байк не выбран"
			field_log.error(message)
	else:
		# var message_en = "You have a bike already"
		var message = "У вас уже есть байк"
		field_log.info(message)
	
	if PlayerData.player_bike:
		$TextureRect/SliderContainer/Buttons/Sataur.flat = false
		$TextureRect/SliderContainer/Buttons/Drawster.flat = false
		$TextureRect/SliderContainer/Buttons/Sataur.disabled = true
		$TextureRect/SliderContainer/Buttons/Drawster.disabled = true


func _on_btn_refit_pressed() -> void:
	if PlayerData.player_bike:
		var bike_upgrade_instance: PopupDialog = bike_upgrade.instance()
		var bike_upgrade_name = bike_upgrade_instance.name # == "BikeUpgradeDialog"
		
		add_child(bike_upgrade_instance)
		yield(get_tree().create_timer(0.4), "timeout")
		
		if has_node(bike_upgrade_name) and get_node(bike_upgrade_name):
			bike_upgrade_instance.open(PlayerData.player_bike)
	else:
		var message = "You have not a bike!"
		field_log.error(message)


func init_slide(bike) -> void:
	.init_slide(bike)
	set_menu_options(bike)
	
	if selected_node and not PlayerData.player_bike and selected_node.price < PlayerData.rms:
		btn_pay.modulate.a = 1


func init_btn_current_node() -> void:
	btn_pay.modulate.a = 0.4
	btn_refit.modulate.a = 0.4
	
	if PlayerData.player_bike:
		init_slide(PlayerData.player_bike)
		btn_refit.modulate.a = 1
		btn_pay.modulate.a = 0.4


func set_menu_options(bike) -> void:
	# EN VERSION
	# var power_text = "Max power: ....... %s" % [bike.max_power]
	# var speed_text = "Max speed: ....... %d" % [bike.max_speed]
	# var jump_text = "Max jump: .......... %d" % [bike.max_height_jump]
	# var lives_text = "Lives: .................... %d" % [PlayerData.lives]
	# var price_text = "Price: .................... %d" % [bike.price]
	# RU VERSION	
	var power_text = "максимальная сила: ............. %s" % [bike.max_power]
	var speed_text = "максимальная скорость: .. %d" % [bike.max_speed]
	var jump_text = "максимальный прыжок: ...... %d" % [bike.max_height_jump]
	var lives_text = "здоровье: .................................... %d" % [PlayerData.lives]
	var price_text = "цена: .............................................. %d" % [bike.price]
	
	menu_options.get_node('MaxPower').set_text(power_text)
	menu_options.get_node('MaxSpeed').set_text(speed_text)
	menu_options.get_node('MaxJump').set_text(jump_text)
	menu_options.get_node('Lives').set_text(lives_text)
	menu_options.get_node('Price').set_text(price_text)


func set_buttons_flat(btn_active: Button) -> void:
	btn_sataur.flat = bool(btn_sataur.name == btn_active.name)
	btn_drawster.flat = bool(btn_drawster.name == btn_active.name)
