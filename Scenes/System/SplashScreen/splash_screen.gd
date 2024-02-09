extends Node2D
# SPLASH SCREEN SCRIPT
@onready var SSNF = $SSNF # splash label

@export var splash_timer: int = 140 # splash timer
var timer_rec: int # records the splash timer


func _ready():
	SSNF.visible_ratio = 0 # make sure all characters are hidden
	timer_rec = splash_timer # record the splash timer

func _process(delta):
	# decrement the splash timer until it reaches 0 and then begin to 
	# increment the visible ratio for the splash label characters 
	if SSNF.visible_ratio != 1:
		if splash_timer > 0:
			splash_timer -= Globals.timer_ctrl * delta
		else:
			SSNF.visible_ratio += 0.5 * delta
	else:
		if timer_rec > 0:
			timer_rec -= Globals.timer_ctrl * delta
		else:
			# load the next scene (main menu)
			var _scene_change = get_tree().change_scene_to_file("res://Scenes/System/MainMenu/main_menu.tscn")
