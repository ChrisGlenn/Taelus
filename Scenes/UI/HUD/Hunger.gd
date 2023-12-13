extends Sprite2D
# HUNGER/THIRST HUD SCRIPT
# basic script that lets me select if this is hunger or thirst and the position that
# it is set at (on the hud from left to right 1 to 5) then it checks the player's hunger
# or thirst and updates if it should be shown or not.
@export_enum("thirst", "hunger") var icon_type : String = "thirst"
@export var icon_position : int = 0 # 1 to 5 left to right 0 is null
var icon # the icon_type recorder


func _ready():
	icon = Globals.player[icon_type] # set the parameter to check

func _process(_delta):
	# check the position and then check if it's below the display 'threshold' 
	# then hide the icon
	pass
