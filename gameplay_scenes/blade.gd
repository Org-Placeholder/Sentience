extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(GameState.game_playing):
		$Sprite.rotate(speed*delta)
#	pass


func _on_Area2D_body_entered(body):
	if(body.has_method("on_wasted")):
			body.on_wasted("Ded by a blade")
	pass # Replace with function body.
