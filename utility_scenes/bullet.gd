extends KinematicBody2D

var direction = Vector2()
var shot = false
const SPEED = 30
var elapsed_time = 0
func shoot(p_direction):
	direction = p_direction
	shot = true
	pass

func _physics_process(delta):
	if(shot):
		move_and_slide(direction*SPEED, Vector2(0, -1))
		elapsed_time += delta
		if(elapsed_time > 2):
			queue_free()
		
