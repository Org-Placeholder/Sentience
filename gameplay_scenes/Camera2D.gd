extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var zoom_on_ground = 1
var zoom_on_jump = 1.5
onready var scale_damage_on_start = $damage.scale
var escape_screen = preload("res://ui_scenes/escape_scene.tscn")
onready var offset_cam = get_parent().get_node("Player/Player").position - position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(GameState.game_playing):
		#center camera on player
		position = lerp(position, get_parent().get_node("Player/Player").position - offset_cam, 0.5)
		
		#damage indicator is set by player calling on_hit on GameState, we directly access the visiblity from there.
		$damage.modulate.a = GameState.get_damage_visiblity()
		
		#following code zooms the camera in and out based on whether player is on ground or jumping.
		var og = get_parent().get_node("Player/Player").onground
		if(!og):
			zoom.x = lerp(zoom.x, zoom_on_jump, 0.03)
			zoom.y = lerp(zoom.y, zoom_on_jump, 0.03)
		else :
			zoom.x = lerp(zoom.x, zoom_on_ground, 0.03)
			zoom.y = lerp(zoom.y, zoom_on_ground, 0.03)
		#scales the damage indicator accordingly
		$damage.scale = scale_damage_on_start * zoom /zoom_on_ground
	else :
		#resetting the zoom on game over or on escape screen
		zoom.x = lerp(zoom.x, zoom_on_ground, 0.03)
		zoom.y = lerp(zoom.y, zoom_on_ground, 0.03)
		$damage.scale = scale_damage_on_start * zoom /zoom_on_ground

func _input(event):
	if(event.as_text() == "Escape"):
		if(Input.is_action_just_pressed("ui_cancel")):
			if(GameState.alive):
				GameState.game_playing = !GameState.game_playing
				if(!GameState.game_playing):
					add_child(escape_screen.instance())
			get_tree().set_input_as_handled()

