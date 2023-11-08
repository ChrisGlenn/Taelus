extends Node
# GLOBAL VARIABLES
# system variables
var menu_mode = "MAIN" # MAIN, SELECTED, INVENTORY, MENU, STATUS
var new_game = true # lets the loading screen know what course to take
var new_scene_player_set = false # if true then the player will reset self based on origin coords
var new_scene_player_origin = Vector2(0,0) # where the player spawns in a new scene
var chunk_a = []

# HUD variables
# selector
var hud_mode = "MAIN" # main, sel (selection), diag (dialogue), stat (status)
var hud_sel_item_name = ""
var hud_sel_icon_frame = 0
var hud_sel_item_desc = ""
var hud_sel_item_cntrl = ""

# player variables
var can_play = true # if the player can play
var in_combat = false # if the game is in combat mode or not
var player_name = "Adan" # player's name
var player_status = "Healthy" # player's current status
var player_armor = [0,0,0,0] # player armor equipped see doc for reference
var player_copper = 20 # player's current amount of copper
var player_silver = 0 # player's current amount of silver
var player_gold = 0 # player's current amount of Gold
var pWeapon_equipped = false # if player weapon is equipped
var player_reputations = "Unknown" # see doc for reference
var player_inventory = [0,0,0,0,0,0,0,0,0,0,0,0] # see doc for reference

# lor variables
var current_region = "Lor"
var current_kingdom = "Kingdom A"
var current_location = "Alphaville"
var current_map_location = "01x01"
var year = 300
var month = 1
var day = 1
var season = 1
var months = ["Morns Light","Inabar's Dance","Ransfir","Gundar's Wake","Noruv's Fire","Sunsfir","Bloodmun","Harvest Fall","First Frost","Night's Fall"]
var month_max_days = [28,22,26,29,30,24,26,24,25,22]
var seasons = ["winter","spring","summer","fall"]
var days_in_game = 0
var cut_trees = [] # holds trees that have been cut
var mined_rocks = [] # holds stones that have been mined

# story/npc variables
var world_billboard = {} # stories that are floating around
var king_married = false # starts false
var king_heir = false # starts false
var king_of_lor = {} # king dictionary
var queen_of_lor = {} # queen dictionary
var prince_of_lor = {} # offspring dictionary
var princcess_of_lor = {} # offspring dictionary
