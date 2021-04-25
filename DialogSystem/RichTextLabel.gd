extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dialogue=["Hello ! Welcome to the game.","Added second dialogue to check dialogue transition"]
var index=0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(dialogue[index])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Timer_timeout():
	
