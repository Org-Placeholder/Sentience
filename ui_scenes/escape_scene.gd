extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	pass # Replace with function body.

func _process(delta):
	if(GameState.game_playing):
		modulate.a = lerp(modulate.a, 0, 0.1)
		if(is_equal_approx(modulate.a, 0)):
			queue_free()
	else:
		modulate.a = lerp(modulate.a, 1, 0.1)

func _on_Resume_pressed():
	GameState.game_playing = true
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
