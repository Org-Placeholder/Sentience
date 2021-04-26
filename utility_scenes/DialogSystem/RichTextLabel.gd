extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dialogue=["Hello ! Welcome to the game.","Added second dialogue to check dialogue transition.","Hope you enjoy the game!!"]
var index=0
var freed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _initialize(p_dialogue):
	dialogue = p_dialogue
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
			else :
				freed = true
		else:
			set_visible_characters(get_total_character_count()) 

func _process(delta):
	if(freed):
		get_parent().modulate.a = lerp(get_parent().modulate.a, 0, 0.05)
		if(is_equal_approx(get_parent().modulate.a, 0)):
			get_parent().queue_free()

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)	


func _on_Button_pressed():
	freed = true
