extends KinematicBody2D

enum{
	IDLE,
	RUN,
	JUMP,
}
const G = 400
const SPEED = 400
const LEFT = -1
const RIGHT = 1
var gun_active = false
var state = IDLE
var direction = LEFT
var onground = false
var velocity = Vector2()

func _ready():
	pass 

func _process(delta):
	pass
	
func _physics_process(delta):
	
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
	if(Input.is_action_pressed("ui_up") && p_onground):
		velocity.y = -SPEED*1.2
	move_and_slide(velocity, Vector2(0, -1))
	if(p_state != state || p_onground != onground):
		match(p_state):
			IDLE:
				if($RayCast2D.is_colliding()):
					if(p_gun):
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
						pass
					else:
						$AnimatedSprite.play("run")
						pass
				else:
					$AnimatedSprite.play("jump")
				pass
			JUMP:
				
				pass
		state = p_state
		onground = p_onground
	pass
	if(p_dir != direction):
		$AnimatedSprite.scale.x = p_dir*abs($AnimatedSprite.scale.x)
		direction = p_dir
