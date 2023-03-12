extends Cfg
class_name BikeCfg

const FILE = "bikes.cfg"

const KEY_TITLE = "title"
const KEY_TEXTURE = "texture"
const KEY_MAX_SPEED = "max_speed"
const KEY_MAX_HEIGHT_JUMP = "max_height_jump"
const KEY_POWER = "power"
const KEY_MAX_POWER = "max_power"
const KEY_PRICE = "price"


func _init():
	prefix = "Bike"
	path_file_cfg = RES + FILE
	config = get_config()


# getters

func get_title(section: String) -> String:
	return config.get_value(section, KEY_TITLE)

func get_texture(section: String) -> String:
	return config.get_value(section, KEY_TEXTURE)

func get_max_speed(section: String) -> float:
	return config.get_value(section, KEY_MAX_SPEED)

func get_max_height_jump(section: String) -> float:
	return config.get_value(section, KEY_MAX_HEIGHT_JUMP)

func get_power(section: String) -> float:
	return config.get_value(section, KEY_POWER)

func get_max_power(section: String) -> float:
	return config.get_value(section, KEY_MAX_POWER)

func get_price(section: String) -> int:
	return config.get_value(section, KEY_PRICE)

 # setters


# methods

func get_bikes() -> Array:
	var store = []
	for section in config.get_sections():
		store.append(as_dict(section))
	return store


func as_dict(section: String) -> Dictionary:
	return {
		KEY_TITLE: get_title(section),
		KEY_TEXTURE: get_texture(section),
		KEY_MAX_SPEED: get_max_speed(section),
		KEY_MAX_HEIGHT_JUMP: get_max_height_jump(section),
		KEY_POWER: get_power(section),
		KEY_MAX_POWER: get_max_power(section),
		KEY_PRICE: get_price(section)
	}


func create(
	title: String,
	texture: String,
	max_speed: float, 
	max_height_jump: float,
	power: float, 
	max_power: float,
	price: int = 0
) -> int:

	var section = get_section(title)
	
	config.set_value(section, KEY_TITLE, title)
	config.set_value(section, KEY_TEXTURE, texture)
	config.set_value(section, KEY_MAX_SPEED, max_speed)
	config.set_value(section, KEY_MAX_HEIGHT_JUMP, max_height_jump)
	config.set_value(section, KEY_POWER, power)
	config.set_value(section, KEY_MAX_POWER, max_power)
	config.set_value(section, KEY_PRICE, price)
	
	return config.save(path_file_cfg)


