extends Node2D
# LOADING GAME
# This loads the game. If the player selects a new game then it spawns the needed components
# to setup a new game. Also sets the date and player's 'birthplace'. If the player is loading
# a save then it will run through the save file and then load the game where the player last
# left off.
var rng = RandomNumberGenerator.new() # random number generator


func _ready():
	rng.randomize() # seed random

func _process(_delta):
	# check if this is a new game to setup or if the player is loading
	# a previously saved game
	if Globals.new_game:
		new_game_setup()

func new_game_setup():
	# SETUP A NEW GAME
	# spawn a 'birth' date
	Globals.month = rng.randi_range(1,Globals.months.size())
	Globals.new_game = false # TESTING
