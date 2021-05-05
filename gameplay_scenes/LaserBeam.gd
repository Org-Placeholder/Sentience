extends RayCast2D

export var cast_speed := 7000.0
export var max_length := 1400
export var growth_time := 0.1
export var on_time := 2
export var time_period := 3
export var rotate_speed = 0
export var up_rot_angle = 0
export var down_rot_angle = 0

onready var casting_particles := $CastingParticles2D
onready var collision_particles := $CollisionParticles2D
onready var beam_particles := $BeamParticles2D
onready var fill := $FillLine2D
onready var tween := $Tween
onready var line_width: float = fill.width
onready var bulb := $BulbBody/Bulb
onready var bulbCollision := $BulbBody/CollisionShape2D

var rotate_vel
var is_casting := false setget set_is_casting
var time
var destroyed

func _ready() -> void:
	fill.visible = true
	set_is_casting(false)
	fill.points[1] = Vector2.ZERO
	time = 0
	rotate_vel = rotate_speed
	destroyed = false

func _physics_process(delta: float) -> void:
	cast_to = (cast_to + Vector2.RIGHT * cast_speed * delta).clamped(max_length)
	cast_beam()

func _process(delta):
	
	if(!destroyed):
		time += delta
		if(time <= on_time):
			set_is_casting(true)
		else:
			set_is_casting(false)
		if(time >= time_period):
			time = 0
		rotation_degrees += rotate_vel * delta
		if(rotation_degrees >= up_rot_angle): 
			rotate_vel = -rotate_speed
		if(rotation_degrees <= down_rot_angle):
			rotate_vel = rotate_speed
	

func set_is_casting(cast: bool) -> void:
	is_casting = cast
	
	if is_casting:
		appear()
	else:
		
		cast_to = Vector2.ZERO
		fill.points[1] = cast_to
		collision_particles.emitting = false
		disappear()

	set_physics_process(is_casting)
	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting


func cast_beam() -> void:
	var cast_point := cast_to

	# Required, the raycast's collisions update one frame after moving otherwise, making the laser
	# overshoot the collision point.
	force_raycast_update()
	if is_colliding():
		cast_point = to_local(get_collision_point())
		collision_particles.process_material.direction = Vector3(
			get_collision_normal().x, get_collision_normal().y, 0
		)

	collision_particles.emitting = is_colliding()

	fill.points[1] = cast_point
	collision_particles.position = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5
	if is_colliding():
		var body = get_collider()
		if body!=null && body.get_name() == "Player":
			body.on_wasted("Fried by a laser")


func appear() -> void:
	$Laser.play()
	$Laser.max_distance=500
	if tween.is_active():
		tween.stop_all()
	tween.interpolate_property(fill, "width", 0, line_width, growth_time * 2)
	tween.start()


func disappear() -> void:
	$Laser.stop()
	if tween.is_active():
		tween.stop_all()
	tween.interpolate_property(fill, "width", fill.width, 0, growth_time)
	tween.start()
	
func on_hit(val):
	if(!destroyed):
		bulb.visible = false
		set_is_casting(false)
		destroyed = true
