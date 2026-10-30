extends Node2D


func _ready():
	$VBox/PlayButton.grab_focus()


func _on_start_button_pressed():
	MatchState.reset()
	get_tree().change_scene_to_file("res://Level1/Level1.tscn")


func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file("res://Tutorial/Tutorial.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
