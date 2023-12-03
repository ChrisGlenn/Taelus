extends CanvasLayer
# ALPHA HUD
# This hud is for the alphafarm which is where the NPC's are tested alongside other things that I 
# need to test outside of player stuff.
@onready var HUD_Text = $Label


func _process(_delta):
	HUD_Text.text = str(Globals.day, " ", Globals.months[Globals.month], " ", Globals.year, "\n")
