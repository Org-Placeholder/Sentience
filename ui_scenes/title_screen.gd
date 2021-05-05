extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var projectResolution=get_viewport_rect()
	$VideoPlayer.rect_size = projectResolution.size
	pass # Replace with function body.

func _process(delta):
	if !$VideoPlayer.is_playing() :
		$VideoPlayer.play()
	pass


func _on_Play_pressed():
	$Click.play()
	var level_num = DataManager.get_last_completed_level() + 1
	get_tree().change_scene("res://gameplay_scenes/levels/level" + str(level_num) + ".tscn")
	pass # Replace with function body.
