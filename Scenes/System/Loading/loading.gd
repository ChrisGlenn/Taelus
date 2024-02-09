extends Node2D
# LOADING SCREEN
# this is where the game begins to load
# if it is a new game then it will spawn the necessary random elements for the game
# otherwise it will pull from the selected save file and set the loaded variables
# all while spawning a random array of words to display on the loading screen
@onready var LOADLABEL = $LoadingLabel # load label
@onready var RNG = RandomNumberGenerator.new() # random number generator

@export var load_terms: Array = [] # holds random terms for the load label to spawn
@export var scroll_speed: int = 2 # defaults to 2
@export var loading_timer = 100 # timer to pad out loading
var loaded = false # if true stop loading...


func _ready():
	RNG.randomize() # seed random
	# set a random word from the load_terms array and make sure the visible ratio is 0
	LOADLABEL.visible_ratio = 0
	LOADLABEL.text = load_terms[RNG.randi_range(0, load_terms.size()-1)]

func _process(delta):
	random_label(delta) # loading label function
	load_game(delta) # load the game


func random_label(clock):
	if LOADLABEL.visible_ratio < 1:
		LOADLABEL.visible = true
		LOADLABEL.visible_ratio += scroll_speed * clock
	else:
		LOADLABEL.visible = false
		LOADLABEL.text = load_terms[RNG.randi_range(0, load_terms.size()-1)]
		LOADLABEL.visible_ratio = 0

func load_game(clock):
	if Globals.new_game:
		if !loaded:
			# the player has selected a new game...
			pass
		else:
			# countdown the timer to pad out the laoding screen
			if loading_timer > 0:
				loading_timer -= Globals.timer_ctrl * clock
			else:
				# move to the loaded scene
				print("LOADING COMPLETE")
	else:
		# load a saved game
		pass
