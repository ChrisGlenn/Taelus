extends Node
# GLOBAL VARIABLES
# system variables
var menu_mode = "MAIN" # MAIN, OPTIONS, LOAD
var perma_death = false # if true save is deleted after death
var new_game = true # lets the loading screen know what course to take
var new_random = false # if true then the loading screen will generate a random player
var new_scene_player_set = false # if true then the player will reset self based on origin coords
var new_scene_player_origin = Vector2(0,0) # where the player spawns in a new scene
var movement_speed = 97 # global movement speed
var timer_ctrl = 100 # timer control
var placed_ = [] # items, ect already placed in the game to stop double spawning
var interior = false # if the player is inside of a building/cave/ect...

# GAMEPLAY
# player settings
var player_scene # player holder
var selector_auto_off = true # if the selector disables after actions
# combat variables
var combat = false # if true the game is in combat mode

# HUD variables
var hud_mode = "MAIN" # main, select (selection), diag (dialogue), stat (status), inv (inventory)
var hud_controlable = true # if false can't change hud modes
var selector_on = false # helps to keep track of selector
var narr_message_icon = 0 # set the narrative message icon
var narr_message_text = "" # the message text to display
var messages = -1 # goes from 0 to 15 before resetting
var message_on = false # HUD message switch
var message_text = "" # text for message
var hud_selected_name = ""
var hud_sel_icon_frame = 0 # enviornment item selected
var hud_selected_desc = ""
var hud_selected_cntrl = ""
var hud_control_mode = "main"
var hud_control = [
	{"mode": "","controls": "ERROR: NO MODE SET"},
	{"mode": "main","controls": "ESC = Menu\nJ = Journal S = Status\nI = Inventory\nCTRL = Interact"},
	{"mode": "return","controls": "ESC = Return"},
	{"mode": "paused","controls": "ESC = Return"},
	{"mode": "selector","controls": "ESC = Return"},
	{"mode": "sel_inv_default","controls": "ESC = Return\nSPACE = Discard"},
	{"mode": "sel_refill","controls": "ESC = Return\nSPACE = Drink\n CTRL = Refill"},
	{"mode": "sel_drink","controls": "ESC = Return\nSPACE = Drink\nCTRL = Empty"},
	{"mode": "sel_eat","controls": "ESC = Return\nSPACE = Eat"},
	{"mode": "pick_up","controls": "ESC = Return\nSPACE = Pick Up\nCTRL = Attack"},
	{"mode": "sel_door_closed","controls": "ESC = Return\nSPACE = Open\nCTRL = Pick Lock\nXXX = Bash Open"},
	{"mode": "sel_door_opened","controls": "ESC = Return\nSPACE = Close"},
	{"mode": "sel_bed","controls": "ESC = Return\nSPACE = Sleep"},
	{"mode": "sel_equip","controls": "ESC = Return\nSPACE = Equip\nCTRL = Discard"},
	{"mode": "sel_unequip","controls": "ESC = Return\nSPACE = Unequip"},
	{"mode": "sel_tree","controls": "ESC = Return\nSPACE = Cutdown"},
	{"mode": "sel_tree_harvest","controls": "ESC = Return\nSPACE = Cutdown\nCTRL = Pick Fruit"}
]

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
	"gender": "Male", # (Gen. 1:27),
	"gender_mod": 0,
	"race": 0,
	"status": "Healthy",
	"strength": 7,
	"agility": 12,
	"endurance": 11,
	"intelligence": 5,
	"charisma": 5,
	"armor_class": 7,
	"str_mod": 0,
	"agi_mod": 5,
	"end_mod": 4,
	"int_mod": -1,
	"cha_mod": -1,
	"bonus_mod": 2,
	"hp": 8,
	"money": [20,0,0],
	"armor": {"finder": "NKD","name": "Naked","influence": -10,"class": "Unequipped","type": "Clothing","armor_class_mod": 0,"durabiliity": -4,"inv_frame": 256,"equip_frame": 0},
	"helmet": "null",
	"amulet": "null",
	"ring_one": "null",
	"ring_two": "null",
	"weapon": "null",
	"shield": "null",
	"reputation": "Unknown",
	"influence": 0,
	"bounty": 0,
	"inventory": [],
	"weight": 0.0,
	"capacity": 72.0,
	"thirst": 100.0,
	"hunger": 100.0,
	"days_left": 5000
}
var player_skills = {
	"alechemy": 0,
	"blacksmithing": 0,
	"defense": 0,
	"unarmored": 0,
	"light_armor": 0,
	"medium_armor": 0,
	"heavy_armor": 0,
	"riding": 0,
	"farming": 0	
}
# the following used to set the player's AC/DMG/Buffs, ect.
var equipment_armor = [
	player["armor"],
	player["helmet"],
	player["shield"]
]
var equipment_jewelry = [
	player["amulet"],
	player["ring_one"],
	player["ring_two"]
]
var equipment_weapon = player["weapon"]

# lor variables
var current_region = "Lor"
var current_kingdom = "Lor"
var current_location = "S. Watchtower"
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
var minutes = 55 # increments by 5
var seconds = 0
var weather = "Sunny" # the current weather
var weather_updated = false # true if weather event is 'running'
var weather_event = "SUN" # the current weather event
var weather_lifespan = 0 # records how long the weather event will last
var months = ["Morns Light","Inabar's Dance","Ransfir","Gundar's Wake","Noruv's Fire","Sunsfir","Bloodmun","Harvest Fall","First Frost","Night's Fall"]
var month_max_days = [28,22,26,29,30,24,26,24,25,22]
var seasons = ["Winter","Spring","Summer","Fall"]
var seasonal_attribute = 4 # the initial stat needed to beat for weather events
var seasonal_weather_mod = [3,1,2,2] # the odds for a weather event for each season
var seasonal_rain = 15 # when it rains this gets incremented from 0 and affects crop output
var days_in_game = 0 # how many days the player has been 'alive' in the game
var months_in_game = 0 # how many months the player has been 'alive' in the game
var trees = [] # holds trees that have been cut
var rocks = [] # holds stones that have been mined
var crops = [] # holds crops that have been planted and their current statusii
# DEBUG CHUNK LOADING SYSTEM
var cam_move_count = 0 # how many times the camera has moved (once it hits a certain number the unneeded chunks are deleted)
var active_scene # the scene that is active
var location_marker_dir = -4 # 0 is up 1 is right 2 is down 3 is left
var loaded_chunks = [] # holds the loaded chunks

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
var start_items = [
	{"finder": "LBE","name" : "Leather Bottle","description" : "A small empty bottle made of leather.","frame" : 1,"weight" : 0.2,"value" : 2,"amnt" : 0,"max_amnt" : 5,"min_amnt" : -4,"stackable" : false,"equip": false,"equipped": false,"equip_slot": "null","type" : "CONSUME","hud_mode" : "sel_drink","func_one" : [0],"func_two" : [0],"func_three" : [0]}
]
