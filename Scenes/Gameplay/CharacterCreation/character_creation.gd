extends Node2D
# CHARACTER CREATION
# This allows the player to create a character
# it's split into multpile sections that will establish a character
@onready var AVATAR = $AvatarCreation
@onready var RACE_SEL = $AvatarCreation/SelectRace/RaceLabel
@onready var RACE_ACTIVE = $AvatarCreation/SelectRace/RaceActive
@onready var GENDER_ACTIVE = $AvatarCreation/SelectGender/GenderActive
@onready var GENDER_SEL = $AvatarCreation/SelectGender/GenderLabel
@onready var BACKG_ACTIVE = $AvatarCreation/Background/BackgroundActive
@onready var BACKG_SEL = $AvatarCreation/Background/BackgroundLabel
@onready var BACKG_DESC = $AvatarCreation/Background/BackgroundDesc
@onready var AVATAR_CHAR = $AvatarCreation/CharPlaceholder
@onready var AVATAR_HAIR = $AvatarCreation/HairPlaceholder
var json_file_path = "res://JSON/System/background.json" # file path to JSON file
var json_data = {} # dictionary to hold json data
var creation_section = 0 # character creation section that is active (0 is avatar/background/starting gold, 1 is stats)
var active_subsection = 0 # active section player is currently using
var char_input_pos = 0 # char_input starting position
var char_selected = false # if a selection has been made


func _ready():
	AVATAR.visible = true # show avatar creation first
	GENDER_ACTIVE.visible = false # hide gender active
	BACKG_ACTIVE.visible = false
	# import and parse JSON data from file
	var json_file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = json_file.get_as_text()
	json_data = JSON.parse_string(content)

func _process(_delta):
	char_creation() # character creation function!!

func char_creation():
	# lets create thy character!!!
	# starts off with the 'avatar' creation screen where the player can select race, sex, hair and background
	# AVATAR
	if creation_section == 0:
		if active_subsection == 0:
			# RACE SELECTION
			if !char_selected:
				# no need to show or hide any other sections since this is the default starting selection
				char_selection(Globals.races.size()-1) # choose a race
				RACE_SEL.text = Globals.races[char_input_pos] # display which race is currently selected
				# update the (male) avatar image based on race
				if char_input_pos < 2:
					# human/western half-fae
					# no need for female frame since the default sex is male
					AVATAR_CHAR.frame = 1
					AVATAR_HAIR.frame = 17
				elif char_input_pos == 2:
					# half-fae (eastern)
					AVATAR_CHAR.frame = 3
					AVATAR_HAIR.frame = 37
					AVATAR_HAIR.global_position.y = 224
				elif char_input_pos == 3:
					# fae westerner
					AVATAR_CHAR.frame = 5
					AVATAR_HAIR.frame = 17
					AVATAR_HAIR.global_position.y = 208
				elif char_input_pos == 4:
					# fae easterner
					AVATAR_CHAR.frame = 7
					AVATAR_HAIR.frame = 37
					AVATAR_HAIR.global_position.y = 208
				elif char_input_pos == 5:
					# ilyad westerner
					print("TEST")
					AVATAR_CHAR.frame = 11
					AVATAR_HAIR.frame = 17
					AVATAR_HAIR.global_position.y = 256
			else:
				Globals.player_race = char_input_pos # record the chosen race
				char_input_pos = 0 # reset char_input_pos
				RACE_ACTIVE.visible = false # hide the arrows
				print(Globals.races[Globals.player_race])
				char_selected = false # reset char_selected
				active_subsection += 1 # advance the player char creation
		elif active_subsection == 1:
			GENDER_ACTIVE.visible = true # show gender_active
			# GENDER SELECTION
			if !char_selected:
				char_selection(Globals.genders.size()-1) # choose a gender
				GENDER_SEL.text = Globals.genders[char_input_pos]
				# update the charplaceholder avatar based on gender
				if char_input_pos == 0:
					# male
					pass
			else:
				Globals.player_gender = Globals.genders[char_input_pos] # record the chosen gender
				char_input_pos = 0 # reset char_input_pos
				GENDER_ACTIVE.visible = false # hide the arrows
				print(Globals.player_gender)
				char_selected = false # rest char_selected
				active_subsection += 1 # advance the char creation
		elif active_subsection == 2:
			pass

func char_selection(num_max):
	# used to select an active character attribute 
	# strictly left and right movement
	if Input.is_action_just_pressed("tae_right"):
		if char_input_pos < num_max: char_input_pos += 1 # increment char_input_pos
		else: print("PLAY SOUND")
	elif Input.is_action_just_pressed("tae_left"):
		if char_input_pos > 0: char_input_pos -= 1 # decrement char_input_pos
		else: print("PLAY SOUND")
	elif Input.is_action_just_pressed("tae_select"):
		# record the set choice and advance active_subsection
		char_selected = true

func char_movement(_num_max):
	pass

func hide_section(_sec):
	# a quick function to hide sections that aren't active and show the one that is
	pass
