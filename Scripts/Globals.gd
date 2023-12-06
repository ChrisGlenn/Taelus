extends Node
# GLOBAL VARIABLES
# system variables
var menu_mode = "MAIN" # MAIN, SELECTED, INVENTORY, MENU, STATUS
var new_game = true # lets the loading screen know what course to take
var new_random = false # if true then the loading screen will generate a random player
var new_scene_player_set = false # if true then the player will reset self based on origin coords
var new_scene_player_origin = Vector2(0,0) # where the player spawns in a new scene

# HUD variables
# selector
var hud_mode = "MAIN" # main, sel (selection), diag (dialogue), stat (status)
var hud_sel_item_name = ""
var hud_sel_icon_frame = 0
var hud_sel_item_desc = ""
var hud_sel_item_cntrl = ""
var hud_controls_main = "M = Main  I = Inventory\nJ = Journal S = Status\nESC = Menu"
var hud_controls_select = ""
var hud_controls_inventory = ""
var hud_controls_diag = ""
var hud_controls_combat = ""

# player variables
var can_play = true # if the player can play
var in_combat = false # if the game is in combat mode or not
var player = {
	"name": "Adan",
	"avatar": 1,
	"head": 17,
	"body": 0,
	"gender": "Male",
	"race": 0,
	"status": "Healthy",
	"armor": [0,0,0,0],
	"money": [20,0,0],
	"weapon": 0,
	"shield": 0,
	"reputation": "Unknown",
	"inventory": [0,0,0,0,0,0,0,0,0,0,0,0],
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
var hour = 12 # noon
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
var chunk_a = {}
