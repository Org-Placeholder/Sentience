extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var EnabledButtons = []

func _ready():
	
	for level in $LevelSelect.get_children():
		level.disabled = true
		
	var levels = $LevelSelect.get_children()
	var level_num = DataManager.get_last_completed_level()
	level_num = min(GameState.max_level,level_num+1)
	for i in range(level_num):
		levels[i].disabled = false


func _on_BackButton_pressed():
	
	get_tree().change_scene("res://ui_scenes/title_screen.tscn")


func _on_1_pressed():
	GameState.level_num = 1
	get_tree().change_scene("res://gameplay_scenes/levels/level1.tscn")


func _on_2_pressed():
	GameState.level_num = 2
	get_tree().change_scene("res://gameplay_scenes/levels/level2.tscn")


func _on_3_pressed():
	GameState.level_num = 3
	get_tree().change_scene("res://gameplay_scenes/levels/level3.tscn") # Replace with function body.


func _on_4_pressed():
	GameState.level_num = 4
	get_tree().change_scene("res://gameplay_scenes/levels/level4.tscn")
 # Replace with function body.

func _on_5_pressed():
	GameState.level_num = 5
	get_tree().change_scene("res://gameplay_scenes/levels/level5.tscn")
 # Replace with function body.
