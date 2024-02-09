extends Node2D
# MAIN MENU
# an alpha version of the main menu for the game


func _process(_delta):
	main_menu() # main menu function


func main_menu():
	# check the user input and then respond accordingly
	if Input.is_action_just_pressed("f1"):
		# new RANDOM game
		var _change_scene = get_tree().change_scene_to_file("res://Scenes/System/Loading/loading.tscn")
	if Input.is_action_just_pressed("f2"):
		# load game
		print("ERROR: Load Game not implemented yet...") # print error/warning
	if Input.is_action_just_pressed("f3"):
		# options
		print("ERROR: Options not implemented yet...") # print error/warning
	if Input.is_action_just_pressed("f4"):
		# quit game
		get_tree().quit()
