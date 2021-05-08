extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(GameState.level_num)
	DataManager.update_level(GameState.level_num , 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Next_pressed():
	GameState.level_num += 1
	print(GameState.level_num)
	$Click.play()
	if(GameState.level_num > GameState.max_level):
		get_tree().change_scene("res://ui_scenes/title_screen.tscn")
	get_tree().change_scene("res://gameplay_scenes/levels/level" + str(GameState.level_num) + ".tscn")
	pass # Replace with function body.
