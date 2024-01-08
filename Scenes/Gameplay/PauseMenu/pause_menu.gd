extends CanvasLayer
# PAUSE MENU
# if the player hits the 'ESC' key then this menu pops up and pauses the game
# works in combat and out of combat.
var pause_mode = "PAUSED" # PAUSED, LOAD, SETTINGS
var cur_pos = 0 # cursor position
var paused_positions = [] # cursor positions for paused
var load_positions = [] # cursor positions for load
var settings_positions = [] # cursor positions for settings


func _ready():
	pass

func _process(_delta):
	pass
