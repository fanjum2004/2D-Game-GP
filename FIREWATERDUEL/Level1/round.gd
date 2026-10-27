extends Node2D

@export var level_number: int = 1
@export var is_final_level: bool = false

var round_over: bool = false


func _ready():
	for p in get_tree().get_nodes_in_group("players"):
		p.died.connect(_on_player_died)
	$UI/LevelLabel.text = "Level %d" % level_number
	$UI/ResultPanel.hide()


func _on_player_died():
	if round_over:
		return
	await get_tree().create_timer(0.3).timeout
	_check_round_end()


func _check_round_end():
	if round_over:
		return
	var alive_players = []
	for p in get_tree().get_nodes_in_group("players"):
		if p.alive:
			alive_players.append(p)
	if alive_players.size() <= 1:
		_end_round(alive_players)


func _end_round(alive_players: Array):
	round_over = true
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()


func _on_continue_button_pressed():
	get_tree().reload_current_scene()


func _on_menu_button_pressed():
	get_tree().reload_current_scene()
