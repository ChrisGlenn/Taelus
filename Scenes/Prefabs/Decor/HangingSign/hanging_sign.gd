extends Area2D
# HANGING SIGN
# A sign that will display a set text to the player
@export var SIGN_TITLE : String = "SIGN TITLE" # the title of the sign
@export_multiline var SIGN_TEXT : String = "SIGN TEXT" # the sign text
@export var FRAME_NO = 1


func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		print("TEST")
		Globals.hud_mode = "SELECT" # change hud to select
		# update the global variables for the HUD
		Globals.hud_selected_name = SIGN_TITLE
		Globals.hud_selected_desc = SIGN_TEXT
		Globals.hud_sel_icon_frame = FRAME_NO
	else:
		print("BAD AREA")

func _on_area_exited(_area):
	# return the hud back to main
	Globals.hud_mode = "MAIN"
