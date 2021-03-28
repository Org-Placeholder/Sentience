extends Sprite


func _process(delta):
	var mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()
	rotation = min(rotation, 0.56)
	rotation = max(rotation, -0.965)
	pass
