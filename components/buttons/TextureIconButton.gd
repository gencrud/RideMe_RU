extends PlayBtn
class_name TextureIconButton

export (String) var title
export (Texture) var icon
export (String, FILE) var change_scene
export (bool) var is_flicker


func _ready():
	set_title(title)
	set_icon(icon)
	
	if is_flicker:
		anim_flicker()


func _on_pressed():
	if not change_scene.empty():
		yield(get_tree().create_timer(0.4), "timeout")
		var res := get_tree().change_scene(change_scene)
		if res != OK: 
			printerr("ERROR: " + str(self) + " " + str(res) + "_on_pressed and change_scene")
	else:
		printerr("[warn] TextureIconButton: Change scene does not init")


func set_title(val) -> void:
	if not val.empty():
		$Label.set_text(val)


func set_icon(val) -> void:
	if val:
		$Icon.texture = val


func anim_flicker() -> void:
	is_flicker = true
	$AnimPlayer.play("flicker")






