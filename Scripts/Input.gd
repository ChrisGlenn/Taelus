extends Node
# INPUT
# provides input for the game based on the current control settings all scripts are here
# so they don't have to be littered all around the game
@onready var PAUSE_MENU = preload("res://Scenes/Gameplay/PauseMenu/pause_menu.tscn")


func player_input(mode, _key):
	match mode:
		"":
			print("ERROR: Mode is not set...")

func pause():
	# pause the game and add a menu
	if !get_tree().paused:
		var pause_menu = PAUSE_MENU.instantiate()
		get_parent().add_child(pause_menu)
		get_tree().paused = true # pause the game
