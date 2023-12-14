extends Sprite2D
# HUNGER/THIRST HUD SCRIPT
# basic script that lets me select if this is hunger or thirst and the position that
# it is set at (on the hud from left to right 1 to 5) then it checks the player's hunger
# or thirst and updates if it should be shown or not.
@export_enum("thirst", "hunger") var icon_type : String = "thirst"
@export var icon_position : int = 0 # 1 to 5 left to right 0 is null
var icon # the icon_type recorder
var rec_frame # the frame that the icon is set to
var start_minute # used for time checking


func _ready():
	icon = Globals.player[icon_type] # set the parameter to check
	rec_frame = frame # record the frame
	start_minute = Globals.minutes # record the minute

func _process(_delta):
	# check the position and then check if it's below the display 'threshold' 
	# then hide the icon
	if start_minute != Globals.minutes:
		icon = Globals.player[icon_type] # set the parameter to check
		# new minute check the hunger/thirst and depending on the icon_position change the frame to 0
		# if below the threshold
		if icon_position == 1:
			# off if 0 and the player will DIE
			if icon < 1:
				frame = 0 # hide this frame
			else: 
				frame = rec_frame # show if above
		elif icon_position == 2:
			# off if below 20
			if icon < 20:
				frame = 0 # hide this frame
			else:
				frame = rec_frame # show if above
		elif icon_position == 3:
			# off if below 40
			if icon < 40:
				frame = 0 # hide this frame
			else:
				frame = rec_frame # show if above
		elif icon_position == 4:
			# off if below 60
			if icon < 60:
				frame = 0 # hide this frame
			else:
				frame = rec_frame # show if above
		elif icon_position == 5:
			# off if below 80
			if icon < 80:
				frame = 0 # hide this frame
			else:
				frame = rec_frame # show if above
		else:
			print("ERROR: icon_position not setup correctly!!!")
		start_minute = Globals.minutes # reset minutes
