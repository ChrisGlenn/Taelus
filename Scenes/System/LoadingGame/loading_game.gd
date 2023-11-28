extends Node2D
# LOADING GAME
# This loads the game. If the player selects a new game then it spawns the needed components
# to setup a new game. Also sets the date and player's 'birthplace'. If the player is loading
# a save then it will run through the save file and then load the game where the player last
# left off.
var rng = RandomNumberGenerator.new() # random number generator
var json_file_path = "res://JSON/System/spawn.json" # file path to JSON file
var json_data = {} # dictionary to hold json data


func _ready():
	rng.randomize() # seed random
	# import and parse JSON data from file
	var json_file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = json_file.get_as_text()
	json_data = JSON.parse_string(content)

func _process(_delta):
	# check if this is a new game to setup or if the player is loading
	# a previously saved game
	if Globals.new_game:
		new_game_setup()

func new_game_setup():
	# SETUP A NEW GAME
	# spawn a 'birth' date
	Globals.year = rng.randi_range(198,370)
	Globals.month = rng.randi_range(1,Globals.months.size())
	# npc spawns
	# royals
	Globals.king_married = rng.randi() % 2 == 0
	if Globals.king_married: Globals.king_heir = rng.randi() % 2 == 0
	Globals.king_of_lor = {
		"Name": "King " + json_data.values()[0]["male_lor_names"][rng.randi_range(0,50)],
		"Age": rng.randi_range(14,36),
		"Days_Left": rng.randi_range(20,8000)
	}
	Globals.queen_of_lor = {
		"Name": "Queen " + json_data.values()[0]["female_lor_names"][rng.randi_range(0,99)],
		"Age": rng.randi_range(13,28),
		"Days_Left": rng.randi_range(20,8000)
	}
	if Globals.year > 320:
		Globals.gradian_lor = randi() % 2 == 0
	Globals.new_game = false # TESTING
