extends Node2D


func _ready():
	var fire_wins = MatchState.wins["fire"]
	var water_wins = MatchState.wins["water"]
	var result_text: String
	if fire_wins > water_wins:
		result_text = "Blaze (Fire) wins the match!\n%d - %d" % [fire_wins, water_wins]
	elif water_wins > fire_wins:
		result_text = "Splash (Water) wins the match!\n%d - %d" % [water_wins, fire_wins]
	else:
		result_text = "It's a tie!\n%d - %d" % [fire_wins, water_wins]
	$ResultLabel.text = result_text


func _on_play_again_button_pressed():
	MatchState.reset()
	get_tree().change_scene_to_file("res://Level1/Level1.tscn")


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")
