extends CanvasModulate
# THE SKY
# day/night cycle that runs for the game
# NOTE: save the color to a global for game saving???
@onready var EMITTER = $Particles # particle emitter
const DAY_COLOR = Color("#ffffff") # color for the day time
const NIGHT_COLOR = Color("#0a0a0a") # color for the night time
var t_cycle = 250 # between cycle times
var cycles = 20 # checks the cycles (10 cycles)
var dawn_dusk = [6,17] # sets time for dawn dusk winter/fall: 6:00am to 5:00pm [6,17] spring/summer: 5:00 to 8:00 [5,20]
var color_tracker = 1.0 # used to update the cycle to know what to dec/inc to...
var timer_rec # records timer_to_cycle
var check_flag = false # used to make checks when needed
var hour_flag # used to make hour checks


func _ready():
	set_season() # set the season
	timer_rec = t_cycle # record timer_to_cycle
	# check the time that this is created and then set the visibility accordingly
	if Globals.hour == dawn_dusk[0]:
		# sun is rising
		if Globals.minutes == 0:
			set_visibility(0.1,0) 
			color_tracker = 0.1
		elif Globals.minutes == 10:
			set_visibility(0.3,0) 
			color_tracker = 0.3
		elif Globals.minutes == 20:
			set_visibility(0.5,0)
			color_tracker = 0.5
		elif Globals.minutes == 30:
			set_visibility(0.7,0)
			color_tracker = 0.7
		elif Globals.minutes == 40:
			set_visibility(0.9,0)
			color_tracker = 0.9
		elif Globals.minutes > 50:
			set_visibility(1,0)
			cycles = 0 # stop the cycles
	elif Globals.hour == dawn_dusk[1]:
		# sun is setting
		if Globals.minutes == 0:
			set_visibility(1,0)
		elif Globals.minutes == 10:
			set_visibility(0.9,0)
			color_tracker = 0.9
		elif Globals.minutes == 20:
			set_visibility(0.7,0)
			color_tracker = 0.7
		elif Globals.minutes == 30:
			set_visibility(0.5,0)
			color_tracker = 0.5
		elif Globals.minutes == 40:
			set_visibility(0.3,0)
			color_tracker = 0.3
		elif Globals.minutes > 50:
			set_visibility(0.1,0)
			cycles = 0 # stop the cycles

	

func _process(delta):
	# the game starts off during the day time SO start this off looking for night...
	if Globals.hour == dawn_dusk[0]:
		# sunrise
		# run the timer, run the dark function that checks if it's met the 'dark' criteria, if not
		# then repeat until it has
		if cycles > 0:
			# check the timer and decrement
			if t_cycle > 0:
				t_cycle -= Globals.timer_ctrl * delta # dec t_cycle
			else:
				cycle(delta,0) # run the cycle function with a 0 (daytime to nighttime)
	elif Globals.hour == dawn_dusk[1]:
		# sunset
		if cycles > 0:
			# check the timer and decrement
			if t_cycle > 0:
				t_cycle -= Globals.timer_ctrl * delta
			else:
				cycle(delta,1) # 1 run for sunset
		else:
			set_season() # see if the season has changed
	else:
		if check_flag:
			# use check_flag to stop this from running in the background ALL THE TIME
			# reset and wait for next sunrise/sunset
			cycles = 20 # reset cycles
			check_flag = false # reset the check_flag
			t_cycle = timer_rec # reset timer_to_cycle
	# WEATHER EVENTS CHECK
	# weather events are checked every hour (on the hour) and when an event is generated
	# it is given a random hour based on a 12 sided die roll then here it is checked and the
	# time is decremented and the globals are updated once the event is over
	if Globals.weather_updated:
		# IF the time_left is -4 then get the weather details from the globals script and then set the
		# time_left by performing a die roll against a 12 sided die to get the hours
		#time_left = Dice.dice_roll(12,0) # get the hours left for the weather event
		#print(str(time_left))
		if Globals.weather_event == "SUN":
			pass


func cycle(clock, sun_direction):
	# direction 0 is day 1 is night
	# direction 0 is day 1 is night
	if sun_direction == 0:
		# sun is rising
		if color.r < color_tracker:
			color.r += 0.1 * clock # increment color RED
			color.g += 0.1 * clock # increment color GREEN
			color.b += 0.1 * clock # increment color BLUE
		else:
			color.r = color_tracker # set to color tracker
			color.g = color_tracker # set to color tracker
			color.b = color_tracker # set to color tracker
			cycles -= 1 # dec cycles
			t_cycle = timer_rec # reset timer to cycle
			if color_tracker < 1.0:
				color_tracker += 0.05 # increment color_tracker
			else:
				cycles = 0 # stop the cycles!
	elif sun_direction == 1:
		# sun is setting
		if color.r > color_tracker:
			color.r -= 0.1 * clock # decrement color RED
			color.g -= 0.1 * clock # decrement color GREEN
			color.b -= 0.1 * clock # decrement color BLUE
		else:
			color.r = color_tracker # set to color tracker
			color.g = color_tracker # set to color tracker
			color.b = color_tracker # set to color tracker
			cycles -= 1 # dec cycles
			t_cycle = timer_rec # reset timer to cycle
			if color_tracker > 0.1:
				color_tracker -= 0.05 # decrement color_tracker
			else:
				cycles = 0 # stop the cycles!


func set_season():
	if !check_flag:
		if Globals.season == 0 || Globals.season == 3:
			# winter/fall
			dawn_dusk = [6,17]
			check_flag = true
		elif Globals.season == 1 || Globals.season == 2:
			# spring/summer
			dawn_dusk = [5,20]
			check_flag = true

func set_visibility(visibility, type):
	if type == 0:
		# used to set the sky visibility when the game starts incase the player
		# loads a game during sunrise or sunset, night or day
		color.r = visibility
		color.g = visibility
		color.b = visibility
	elif type == 1:
		# used to set the visibility to darker or lighter depending on the
		# weather event...which is waht type 1 is used for
		pass