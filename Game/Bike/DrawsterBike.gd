extends EmptyBike
class_name DrawsterBike


func _init(section: String = "Bike_Дравстер"):
	._init(section)


static func create_for_cfg() -> void:
	var texture = "res://Game/Bike/assets/II/sprites.png"
	var max_speed = 700.0
	var max_power = 600.0
	var max_height_jump = 500.0
	var power = 300.0
	var price: = 90
	var bike_cfg: BikeCfg = load(PathData.BIKE_MODEL).new()
	var res := bike_cfg.create("Дравстер", texture, max_speed, max_height_jump, power, max_power, price)
	if res != OK:
		printerr("ERROR: DrawsterBike create_for_cfg")
