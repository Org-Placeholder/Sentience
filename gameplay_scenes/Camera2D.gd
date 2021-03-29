extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var offset_cam = get_parent().get_node("Player/Player").position - position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	position = get_parent().get_node("Player/Player").position - offset_cam
