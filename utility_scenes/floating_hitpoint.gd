extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x1 = Color(1, 0, 0)
var x2 = Color(0.96, 1, 0)
var x3 = Color(0, 1, 0)
var x4 = Color(0, 1, 1)
var x5 = Color(1, 0, 0.86)
var colors = [x1, x2, x3, x4, x5]
var dir
# Called when the node enters the scene tree for the first time.
func _ready():
	rand_seed(OS.get_ticks_msec())
	var i = int(rand_range(0, 10))%5
	set("custom_colors/font_color", colors[i])
	var mul_x
	if  randi()%2==0 :
		mul_x = 1
	else :
		mul_x = -1
	var mul_y
	if  randi()%2==0 :
		mul_y = 1
	else :
		mul_y = -1
	dir = Vector2(rand_range(20, 40)*mul_x, rand_range(20, 40)*mul_y)
	rect_position += dir
	pass # Replace with function body.

func _initialize(val):
	text = str(val)

func _process(delta):
	set("size", 45 + 45*sin(delta*100))
	modulate.a = lerp(modulate.a, 0, 0.05)
	rect_position += dir * delta
	pass
