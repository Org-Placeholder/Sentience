extends KinematicBody2D

var direction = Vector2()
var shot = false
const SPEED = 30
var elapsed_time = 0
var bullet = true
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

func _on_Area2D_body_entered(body):
	if(!body.get("bullet")):
		shot = false
		$Sprite.visible = false
		$EffekseerEmitter2D.play()
		if(body.has_method("on_hit")):
			body.on_hit()
		yield(get_tree().create_timer(2), "timeout")
		queue_free()
	pass