extends Node

var game_data = {}

func _ready():
	load_game()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		game_data["level"] = 0
		save_game()
		pass 
	else:
		save_game.open("user://savegame.save", File.READ)
		game_data = parse_json(save_game.get_line())
		save_game.close()
	pass

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	save_game.store_line(to_json(game_data))
	save_game.close()
	pass

func get_data():
	return game_data
	
func get_last_completed_level():
	return game_data["level"]

func update_level(level_num, time):
	if str(level_num) in game_data:
		if(game_data[str(level_num)] > time):
			game_data[str(level_num)] = time
	else :
		game_data[str(level_num)] = time
	if(game_data["level"] < level_num):
		game_data["level"] = level_num
	save_game()
