extends Sprite

var bullet = preload("res://utility_scenes/bullet.tscn")

func _process(delta):
	if(GameState.game_playing):
		var mouse_position = get_local_mouse_position()
		rotation += mouse_position.angle() + 0.1
		rotation = min(rotation, 0.56)
		rotation = max(rotation, -0.965)
		if(Input.is_action_just_pressed("ui_lmb")):
			if(get_parent().get_parent().gun_active):
				var bullet_inst = bullet.instance()
				bullet_inst.rotation = global_rotation
				bullet_inst.position = $aim.global_position
				bullet_inst.scale = global_scale
				get_tree().root.add_child(bullet_inst)
				var dir = $aim.global_position - $pivot.global_position
				bullet_inst.shoot(dir)
			pass

