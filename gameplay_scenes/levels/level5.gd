extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var d_system = preload("res://utility_scenes/DialogSystem/Dialog.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogue=["Good luck!"]
	var ds_instance = d_system.instance()
	$Camera2D.add_child(ds_instance)
	#ds_instance.translate(Vector2(1935,-4017))
	ds_instance.get_node("RichTextLabel")._initialize(dialogue)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
