extends Node2D
# MAIN MENU
# the main menu for the game (Alpha Version)

func _process(_delta):
	input() # input function

func input():
	# check input and act accordingly
	if Input.is_action_just_pressed("f1"):
		# new game (go to character creation screen)
		var _start_game = get_tree().change_scene_to_file("res://Scenes/Gameplay/CharacterCreation/character_creation.tscn")
		print("WARNING: Character creation not completed. Restart and choose 'new RANDOM game'...")
	elif Input.is_action_just_pressed("f2"):
		# new RANDOM game
		# this will go straight to the loading screen and randomly generate a character for the player to play as
		Globals.new_random = true # turn on new random flag
		var _start_game = get_tree().change_scene_to_file("res://Scenes/System/LoadingGame/loading_game.tscn")
	elif Input.is_action_just_pressed("f3"):
		# options
		# not set yet
		print("WARNING: Options not available...")
	elif Input.is_action_just_pressed("f4"):
		# load game
		print("WARNING: Load game not available...")
	elif Input.is_action_just_pressed("tae_cancel"):
		# quit game
		print("CLOSING GAME")
		get_tree().quit()
