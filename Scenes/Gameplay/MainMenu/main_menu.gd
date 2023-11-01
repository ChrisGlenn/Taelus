extends Node2D
# MAIN MENU
# the main menu for the game (Alpha Version)

func _process(_delta):
	input() # input function

func input():
	# check input and act accordingly
	if Input.is_action_just_pressed("tae_select"):
		# new game (go to character creation screen)
		var _start_game = get_tree().change_scene_to_file("res://Scenes/Gameplay/CharacterCreation/character_creation.tscn")
	elif Input.is_action_just_pressed("tae_mode"):
		# load game
		print("WARNING: Load game not available...")
	elif Input.is_action_just_pressed("tae_cancel"):
		# quit game
		get_tree().quit()
