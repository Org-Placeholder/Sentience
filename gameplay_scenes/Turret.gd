extends StaticBody2D

export var rotate_speed = 25.0
export var up_rot_angle = 18
export var down_rot_angle = -18
export var bullet: PackedScene
export var detectionResetTime := 3
export var timeBetweenShots = 0.4
export var recoil_comeback_weight = 0.5
export var hitpoints = 50
export var bullet_strength = 10
var rotate_vel
onready var head = $Head
onready var ray = $Head/RayCast2D
onready var headSprite1 = $Head/Sprite
onready var headSprite2 = $Head/Sprite2
onready var baseSprite1 = $Base
onready var baseSprite2 = $Base2
var obstacle = true
var time = 0
var timeSinceLastShot = 0;
var start_position
var health = hitpoints
var destroyed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	rotate_vel = rotate_speed # Replace with function body.
	start_position = $Head.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!destroyed):
		head.rotation_degrees += rotate_vel * delta
		if(head.rotation_degrees >= up_rot_angle || head.rotation_degrees <= down_rot_angle):
			rotate_vel *= -1
		checkCollision()
		timeSinceLastShot += delta
		time += delta
		if time >= detectionResetTime:
			changeDetection(false)
		$Head.position = lerp($Head.position, start_position, recoil_comeback_weight)
	
func changeDetection(detected)->void:
	if(detected):
		headSprite1.visible = false;
		headSprite2.visible = true;
		baseSprite1.visible = false;
		baseSprite2.visible = true;
	else :
		headSprite2.visible = false;
		headSprite1.visible = true;
		baseSprite2.visible = false;
		baseSprite1.visible = true;
		
func shoot()->void:
	var temp = bullet.instance()
	add_child(temp)
	temp.global_position = ray.global_position + Vector2(-10,0)
	temp.rotation_degrees = head.rotation_degrees
	temp.shoot(ray.get_collision_point()-position, bullet_strength)
	timeSinceLastShot = 0;
	$Head.translate(Vector2(50, 0).rotated(rotation))
	
func checkCollision()->void:
	if ray.is_colliding():
		var body = ray.get_collider()
		if body!=null && body.get_name() == "Player":
			changeDetection(true)
			time = 0;
			if(timeSinceLastShot >= timeBetweenShots):
				timeSinceLastShot = 0
				shoot()
		
func on_hit(val):
	if(!destroyed):
		health -= val
		$hitpoint_launcher.launch(val)
		if(health < 0) :
			destroyed = true
			$Base.visible = false
			$Base2.visible = false
			$Head.visible = false
			$EffekseerEmitter2D.play() 
			yield(get_tree().create_timer(2), "timeout")
			queue_free()
