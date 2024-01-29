extends Sprite2D
# HUNGER/THIRST HUD SCRIPT
# basic script that lets me select if this is hunger or thirst and the position that
# it is set at (on the hud from left to right 1 to 5) then it checks the player's hunger
# or thirst and updates if it should be shown or not.
@export_enum("thirst", "hunger") var icon_type : String = "thirst"
@export var icon_position : int = 0 # 1 to 5 left to right 0 is null
var icon # the icon_type recorder
var rec_frame # the frame that the icon is set to


func _ready():
	icon = Globals.player[icon_type] # set the parameter to check
	rec_frame = frame # record the frame

func _process(_delta):
	# check the position and then check if it's below the display 'threshold' 
	# then hide the icon
	icon = Globals.player[icon_type] # set the parameter to check
	# new minute check the hunger/thirst and depending on the icon_position change the frame to 0
	# if below the threshold
	if icon_position == 1:
		# if icon below 10
		# off if 0 and the player will DIE
		if icon > 10:
			frame = rec_frame
		elif (icon < 10 && icon > 0):
			frame = rec_frame + 2
		else:
			frame = 0
	elif icon_position == 2:
		# below 30
		if icon > 30:
			frame = rec_frame
		elif (icon < 30 && icon > 20):
			frame = rec_frame + 2
		else:
			frame = 0
	elif icon_position == 3:
		# below 50
		if icon > 50:
			frame = rec_frame
		elif (icon < 50 && icon > 40):
			frame = rec_frame + 2
		else:
			frame = 0
	elif icon_position == 4:
		# below 70
		if icon > 70:
			frame = rec_frame
		elif (icon < 70 && icon > 60):
			frame = rec_frame + 2
		else:
			frame = 0
	elif icon_position == 5:
		# below 90
		if icon > 90:
			frame = rec_frame
		elif (icon < 90 && icon > 80):
			frame = rec_frame + 2
		else:
			frame = 0
	else:
		print("ERROR: icon_position not setup correctly!!!")
