extends Node2D
# CHARACTER CREATION
# This allows the player to create a character
# it's split into multpile sections that will establish a character
@onready var AVATAR = $AvatarCreation
@onready var RACE_SEL = $AvatarCreation/SelectRace/RaceLabel
@onready var RACE_ACTIVE = $AvatarCreation/SelectRace/RaceActive
var creation_section = "AVATAR" # character creation section that is active
var active_subsection = "RACE" # active section player is currently using
var race_selection = ["Human (Northerner)","Half-Fae (Western)","Half-Fae (Eastern)","Fae (Westerner)","Fae (Easterner)","Ilyan (Southerner)"] # races to select
var char_input_pos = 0 # char_input starting position


func _ready():
	AVATAR.visible = true # show avatar creation first

func _process(_delta):
	char_creation() # character creation function!!

func char_creation():
	# lets create thy character!!!
	# starts off with the 'avatar' creation screen where the player can select race, sex, hair and background
	# AVATAR
	if creation_section == "AVATAR":
		if active_subsection == "RACE":
			# no need to show or hide any other sections since this is the default starting selection
			char_selection(race_selection.size()-1) # choose a race
			RACE_SEL.text = race_selection[char_input_pos] # display which race is currently selected

func char_selection(num_max):
	# used to select an active character attribute 
	# strictly left and right movement
	if Input.is_action_just_pressed("tae_right"):
		if char_input_pos < num_max: char_input_pos += 1 # increment char_input_pos
		else: pass # PLAY SOUND
	elif Input.is_action_just_pressed("tae_left"):
		if char_input_pos > 0: char_input_pos -= 1 # decrement char_input_pos
		else: pass # PLAY SOUND

func char_movement(_num_max):
	pass

func hide_section(_sec):
	# a quick function to hide sections that aren't active and show the one that is
	pass
