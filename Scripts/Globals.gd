extends Node
# GLOBAL VARIABLES
# system variables
var menu_mode = "MAIN" # MAIN, OPTIONS, LOAD
var perma_death = false # if true save is deleted after death
var new_game = true # lets the loading screen know what course to take
var new_random = false # if true then the loading screen will generate a random player
var new_scene_player_set = false # if true then the player will reset self based on origin coords
var new_scene_player_origin = Vector2(0,0) # where the player spawns in a new scene
var movement_speed = 76 # global movement speed

# GAMEPLAY
# combat variables
var combat = false # if true the game is in combat mode

# HUD variables
# selector
var hud_mode = "MAIN" # main, select (selection), diag (dialogue), stat (status), inv (inventory)
var messages = -1 # goes from 0 to 15 before resetting
var message_on = false # HUD message switch
var message_text = "" # text for message
var hud_selected_name = ""
var hud_sel_icon_frame = 0
var hud_selected_desc = ""
var hud_selected_cntrl = ""
var hud_control_mode = "main"
var hud_control = {
	"001" : {"mode": "","controls": "ERROR: NO MODE SET"},
	"002" : {"mode": "main","controls": "ESC = Menu\nJ = Journal\n S = Status I = Inventory\n CTRL = Interact"},
	"003" : {"mode": "return","controls": "ESC = Return"},
	"004" : {"mode": "paused","controls": "ESC = Return"},
	"005" : {"mode": "selector","controls": "ESC = Return"},
	"006" : {"mode": "sel_drink_refill","controls": "ESC = Return\nSPACE = Drink\n CTRL = Refill Waterskin"},
	"007" : {"mode": "sel_drink","controls": "ESC = Return\nSPACE = Drink"},
	"008" : {"mode": "sel_eat","controls": "ESC = Return\nSPACE = Eat"}
}

# player variables
var can_play = true # if the player can play
var player_x = 0 # player's current X
var player_y = 0 # player's current Y
var in_combat = false # if the game is in combat mode or not
var player = {
	"name": "Adan",
	"avatar": 1,
	"head": 17,
	"body": 0,
	"gender": "Male",
	"race": 0,
	"status": "Healthy",
	"strength": 7,
	"agility": 12,
	"endurance": 11,
	"intelligence": 5,
	"charisma": 5,
	"armor_class": 7,
	"bonus_mod": 2,
	"hp": 8,
	"armor": [0,0,0,0],
	"money": [20,0,0],
	"weapon": 0,
	"shield": 0,
	"reputation": "Unknown",
	# inventory example {"item": 1,"control": "sel_drink","name": "WATERSKIN","desc": "A waterskin made of leather.","amnt": 2,"max_amnt": 5,"weight": 0.2}
	"inventory": [],
	"weight": 0.0,
	"capacity": 72.0,
	"thirst": 100.0,
	"hunger": 100.0,
	"days_left": 5000
}

# lor variables
var current_region = "Lor"
var current_kingdom = "Kingdom A"
var current_location = "Alphaville"
var current_map_location = "01x01"
var races = ["Human (Northerner)","Half-Fae (Western)","Half-Fae (Eastern)","Fae (Westerner)","Fae (Easterner)","Ilyan (Southerner)"]
var genders = ["Male", "Female"] # (Gen. 1:27)
var background = []
var background_description = []
var year = 300
var month = 2
var day = 6
var season = 1
var hour = 9 # 9am
var minutes = 0 # 60 seconds
var seconds = 0
var months = ["Morns Light","Inabar's Dance","Ransfir","Gundar's Wake","Noruv's Fire","Sunsfir","Bloodmun","Harvest Fall","First Frost","Night's Fall"]
var month_max_days = [28,22,26,29,30,24,26,24,25,22]
var seasons = ["Winter","Spring","Summer","Fall"]
var days_in_game = 0
var cut_trees = [] # holds trees that have been cut
var mined_rocks = [] # holds stones that have been mined
var crops = [] # holds crops that have been planted and their current statusii

# story/npc variables
var world_billboard = {} # stories that are floating around
var king_married = false # starts false
var king_heir = false # starts false
var king_of_lor = {} # king dictionary
var queen_of_lor = {} # queen dictionary
var prince_of_lor = {} # offspring dictionary
var princcess_of_lor = {} # offspring dictionary
var gradian_lor = false # if set true then Gradia has taken over Lor
# data 'chunks', or dictionaries, that will hold data that needs to be kept track of throughout the game. 
# chunk a = NPC's/Players days left, health, ect
var chunk_days = {}
