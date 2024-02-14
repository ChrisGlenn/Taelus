extends Node2D
# SPLASH SCREEN
# The splash screen for this game will count in, slowly display the 6794 text and
# then count out to the main menu the user will not be able to skip this
@onready var NAMELABEL = $Text6794
var splash_timer = 100 # timer in
var timer_out = 220 # timer rec
var text_speed = 1 # speed to display the name text


func _ready():
	NAMELABEL.visible_ratio = 0 # make sure no text is displayed

func _process(delta):
	# countdown the splash timer and then show the text
	if splash_timer > 0:
		splash_timer -= Globals.timer_ctrl * delta
	else:
		if NAMELABEL.visible_ratio < 1:
			# slowly display the text
			NAMELABEL.visible_ratio += text_speed * delta
		else:
			NAMELABEL.visible_ratio = 1 # set it to a solid 1
			if timer_out > 0:
				# countdown to main menu
				timer_out -= Globals.timer_ctrl * delta
			else:
				# go to main menu
				var _start_game = get_tree().change_scene_to_file("res://Scenes/Gameplay/MainMenu/main_menu.tscn")
