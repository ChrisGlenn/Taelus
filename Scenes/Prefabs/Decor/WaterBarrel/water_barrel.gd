extends Area2D
# WATER BARREL
# A water barrel that is open. The player can refill their waterskin (if they have one)
# or just take a straight drink. The waterskin will 'filter' it but if the player drinks straight out
# then there is a small chance they may get sick...
@export var SIGN_TITLE : String = "SIGN TITLE" # the title of the sign
@export_multiline var SIGN_TEXT : String = "SIGN TEXT" # the sign text
@export var FRAME_NO = 1
@export var DRINK_RISK = 0 # percentage
var hit_points = 10 # has 1 hit point
var dead = false # death check * may not be needed *


func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		Globals.hud_mode = "SELECT" # change hud to select
		# update the global variables for the HUD
		Globals.hud_selected_name = SIGN_TITLE
		Globals.hud_selected_desc = SIGN_TEXT
		Globals.hud_sel_icon_frame = FRAME_NO

func _on_area_exited(_area):
	# return the hud back to main
	Globals.hud_mode = "MAIN"
