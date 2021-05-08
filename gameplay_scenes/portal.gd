extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time_elapsed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	time_elapsed += delta
	if(time_elapsed > 10):
		time_elapsed = 0
		$EffekseerEmitter2D.play()
		
func _on_Area2D_body_entered(body):
	if(body.has_method("on_wasted")):
			print("Enter")
			get_tree().change_scene("res://ui_scenes/success_scene.tscn")
	pass # Replace with function body.
