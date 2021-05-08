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
	$Click.play()
	#the lower if statement should be changed to if else tree to support multiple level
	if(true):
		GameState.game_playing = true
		GameState.alive = true
		print(GameState.level_num)
		get_tree().change_scene("res://gameplay_scenes/levels/level" + str(GameState.level_num) + ".tscn")
	pass # Replace with function body.
