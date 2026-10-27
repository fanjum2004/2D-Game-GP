extends Node


var wins = {"fire": 0, "water": 0}


func reset():
	wins = {"fire": 0, "water": 0}


func record_win(element: String):
	if wins.has(element):
		wins[element] += 1
