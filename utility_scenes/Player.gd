extends RigidBody2D

enum{
	IDLE,
	RUN,
	JUMP,
}
const LEFT = -1
const RIGHT = 1
var gun_active = false
var state = IDLE
var direction = LEFT
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var p_state = IDLE
	var p_gun = false
	var p_dir = direction
	if(Input.is_action_pressed("ui_right")):
		p_dir = RIGHT
		p_state = RUN
		apply_central_impulse(Vector2(5, 0))
	if(Input.is_action_pressed("ui_left")):
		p_dir = LEFT
		p_state = RUN
		apply_central_impulse(Vector2(-5, 0))
	if(Input.is_action_pressed("ui_up")):
		if($RayCast2D.is_colliding()):
			apply_central_impulse(Vector2(0, -60))
	if(p_state != state):
		match(p_state):
			IDLE:
				if(p_gun):
					pass
				else:
					$AnimatedSprite.play("idle")
					pass
				pass
			RUN:
				if(p_gun):
					pass
				else:
					$AnimatedSprite.play("run")
					pass
				pass
			JUMP:
				
				pass
		state = p_state
	pass
	if(p_dir != direction):
		$AnimatedSprite.scale.x = p_dir*abs($AnimatedSprite.scale.x)
		direction = p_dir
