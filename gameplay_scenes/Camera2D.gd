extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var escape_screen = preload("res://ui_scenes/escape_scene.tscn")
onready var offset_cam = get_parent().get_node("Player/Player").position - position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(GameState.game_playing):
		position = get_parent().get_node("Player/Player").position - offset_cam
		
func _input(event):
	if(event.as_text() == "Escape"):
		if(Input.is_action_just_pressed("ui_cancel")):
			GameState.game_playing = !GameState.game_playing
			if(!GameState.game_playing):
				add_child(escape_screen.instance())
			get_tree().set_input_as_handled()

