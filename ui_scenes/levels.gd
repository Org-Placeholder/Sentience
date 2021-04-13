extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var x_max_offset
var og_position
# Called when the node enters the scene tree for the first time.
func _ready():
	x_max_offset = $Position2D2.position.x - $Position2D.position.x
	og_position = $Node2D.position.x
	pass # Replace with function body.

func _on_HScrollBar_value_changed(value):
	print(value)
	var offset = value * x_max_offset / 100
	$Node2D.position.x = og_position - offset
	pass
