extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hitpoint_label = preload("res://utility_scenes/floating_hitpoint.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func launch(val):
	var hit_inst = hitpoint_label.instance()
	hit_inst.rect_position = global_position
	hit_inst._initialize(val)
	get_tree().root.add_child(hit_inst)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
