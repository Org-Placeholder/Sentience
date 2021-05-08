extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var max_level = 1
var game_playing = true
var alive = true
var damage_modulate = 0
var level_num = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hit():
	damage_modulate = lerp(damage_modulate, 1, 0.8)
	
func get_damage_visiblity():
	return damage_modulate

func _process(delta):
	damage_modulate = lerp(damage_modulate, 0, 0.03)
