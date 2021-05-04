extends KinematicBody2D

enum{
	IDLE,
	RUN,
	JUMP,
}
const G = 2000
const SPEED = 800
const JUMP_SPEED = 1000
const LEFT = -1
const RIGHT = 1
const JUMP_REMEMBER_TIME = 0.2
const ONGROUND_REMEMBER_TIME = 0.2 
var gun_active = false
var state = IDLE
var direction = RIGHT
var onground = false
var velocity = Vector2()
var failure_screen = preload("res://ui_scenes/failure_scene.tscn")
var jump_remember_time_left = -1
var ground_remember_time_left = -1 
func _physics_process(delta):
	if(GameState.game_playing):
		var p_state = IDLE
		var p_gun = false
		var p_dir = direction
		var p_onground = $RayCast2D.is_colliding()
		if(p_onground):
			velocity.y = 0
		else:
			velocity.y += G*delta
		if(Input.is_action_pressed("ui_right")):
			p_dir = RIGHT
			p_state = RUN
		if(Input.is_action_pressed("ui_left")):
			p_dir = LEFT
			p_state = RUN
		if(Input.is_action_pressed("ui_rmb")):
			p_gun = true && onground
		if(p_state == IDLE):
			if(p_onground):
				velocity.x = lerp(velocity.x, 0, 0.7)
			else:
				velocity.x = lerp(velocity.x, 0, 0.001)
		else:
			if(p_onground):
				velocity.x = lerp(velocity.x, SPEED*p_dir, 0.7)
			else:
				velocity.x = lerp(velocity.x, SPEED*p_dir/2, 0.7)
		jump_remember_time_left -= delta 
		ground_remember_time_left -= delta 
		if(Input.is_action_just_pressed("ui_up")):
			jump_remember_time_left = JUMP_REMEMBER_TIME
		if(p_onground): 
			ground_remember_time_left = ONGROUND_REMEMBER_TIME 
		if(jump_remember_time_left > 0 && ground_remember_time_left > 0):
			jump_remember_time_left = 0
			ground_remember_time_left = 0
			velocity.y = -JUMP_SPEED
		if(Input.is_action_just_released("ui_up")):
			if(velocity.y < 0): 
				velocity.y /= 2 
			
		move_and_slide(velocity, Vector2(0, -1))
		if(p_state != state || p_onground != onground || p_gun != gun_active):
			match(p_state):
				IDLE:
					if($RayCast2D.is_colliding()):
						if(p_gun):
							$AnimatedSprite.play("gunidle")
							pass
						else:
							$AnimatedSprite.play("idle")
							pass
					else:
						$AnimatedSprite.play("jump")
					pass
				RUN:
					if($RayCast2D.is_colliding()):
						if(p_gun):
							$AnimatedSprite.play("gunrun")
							pass
						else:
							$AnimatedSprite.play("run")
							pass
					else:
						$AnimatedSprite.play("jump")
					pass
				JUMP:
					
					pass
		pass
		$AnimatedSprite/gun.visible = p_gun
		state = p_state
		onground = p_onground
		gun_active = p_gun
		if(p_dir != direction):
			$AnimatedSprite.scale.x = p_dir*abs($AnimatedSprite.scale.x)
			direction = p_dir

func on_hit(val):
	$AnimatedSprite/hitpoint_launcher.launch(val)
	GameState.hit()
	pass
	
func on_wasted(message):
	GameState.game_playing = false
	GameState.alive = false
	var f_screen = failure_screen.instance()
	get_parent().get_parent().get_node("Camera2D").add_child(f_screen)
	f_screen.get_node("Label").text = message
	#handle death and show message
	pass
