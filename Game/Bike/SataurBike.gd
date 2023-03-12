extends EmptyBike
class_name SataurBike


func _init(section = "Bike_Сатаур"):
	._init(section)


static func create_for_cfg() -> void:
	var texture = "res://Game/Bike/assets/I/sprites.png"
	var max_speed = 650.0
	var max_power = 620.0
	var max_height_jump = 520.0
	var power = 300.0
	var price: = 90
	var bike_cfg: BikeCfg = load(PathData.BIKE_MODEL).new()
	var res := bike_cfg.create("Сатаур", texture, max_speed, max_height_jump, power, max_power, price)
	if res != OK:
		printerr("ERROR: SataurBike create_for_cfg")
