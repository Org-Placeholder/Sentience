extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Retry_pressed():
	#the lower if statement should be changed to if else tree to support multiple level
	if(true):
		GameState.game_playing = true
		get_tree().change_scene("res://gameplay_scenes/levels/level1.tscn")
	pass # Replace with function body.
