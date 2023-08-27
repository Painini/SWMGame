extends Node


const savePath = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"playerMP": Game.playerMP,
		"gold": Game.gold
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func loadGame():
	var file = FileAccess.open(savePath, FileAccess.READ)
	if FileAccess.file_exists(savePath) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if (current_line):
				Game.PlayerHP = current_line["playerHP"]
				Game.gold = current_line["gold"]
				Game.playerMP = current_line["playerMP"]
