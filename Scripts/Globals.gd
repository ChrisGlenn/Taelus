extends Node
# GLOBAL VARIABLES
# system variables
var menu_mode = "MAIN" # MAIN, SELECTED, INVENTORY, MENU, STATUS

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
var months = []
var seasons = []
var days_in_game = 0
var cut_trees = [] # holds trees that have been cut
var mined_rocks = [] # holds stones that have been mined

# story variables
