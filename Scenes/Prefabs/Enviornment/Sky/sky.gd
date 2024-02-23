extends CanvasModulate
# THE SKY
# day/night cycle that runs for the game
# NOTE: save the color to a global for game saving???
const DAY_COLOR = Color("#ffffff") # color for the day time
const NIGHT_COLOR = Color("#0a0a0a") # color for the night time
var t_cycle = 350 # between cycle times
var cycles = 20 # checks the cycles (10 cycles)
var dawn_dusk = [6,18] # sets time for dawn dusk winter/fall: 6:00am to 6:00pm [6,18] spring/summer: 5:00 to 8:00 [5,20]
var color_tracker = 1.0 # used to update the cycle to know what to dec/inc to...
var timer_rec # records timer_to_cycle
var check_flag = false # used to make checks when needed


func _ready():
	set_season() # set the season
	timer_rec = t_cycle # record timer_to_cycle

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
			color_tracker += 0.5 # increment color_tracker
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
			color_tracker -= 0.05 # decrement color_tracker

func set_season():
	if !check_flag:
		if Globals.season == 0 || Globals.season == 3:
			# winter/fall
			dawn_dusk = [6,18]
			check_flag = true
		elif Globals.season == 1 || Globals.season == 2:
			# spring/summer
			dawn_dusk = [5,20]
			check_flag = true
