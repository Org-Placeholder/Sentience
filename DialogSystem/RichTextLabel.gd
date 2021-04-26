extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dialogue=["Hello ! Welcome to the game.","Added second dialogue to check dialogue transition.","Hope you enjoy the game!!"]
var index=0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(dialogue[index])
	set_visible_characters(0)
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		if get_visible_characters() > get_total_character_count():
			if index < dialogue.size() - 1 :
				index=index+1
				set_bbcode(dialogue[index])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count()) 

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)	


func _on_Button_pressed():
	if index < dialogue.size()-1:
		index=dialogue.size()-1;
		set_bbcode(dialogue[index])
		set_visible_characters(0)
