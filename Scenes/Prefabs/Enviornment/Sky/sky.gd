extends CanvasModulate
# THE SKY
# day/night cycle that runs for the game
# NOTE: save the color to a global for game saving???
const DAY_COLOR = Color("#ffffff") # color for the day time
const NIGHT_COLOR = Color("#0a0a0a") # color for the night time
var t_cycle = 150 # between cycle times
var cycle_timer = 15 # 150 gets you all the way, baby so 10 counts of 15 seconds each
var cycles = 10 # checks the cycles (10 cycles)
var dawn_dusk = [6,18] # sets time for dawn dusk winter/fall: 6:00am to 6:00pm [6,18] spring/summer: 5:00 to 8:00 [5,20]
var d_time = 0 # used to set color off time
var timer_rec # records timer_to_cycle
var cTimer_rec # records cycle_timer
var check_flag = false # used to make checks when needed


func _ready():
	set_season() # set the season
	timer_rec = t_cycle # record timer_to_cycle
	cTimer_rec = cycle_timer # record cycle_timer

func _process(delta):
	# the game starts off during the day time SO start this off looking for night...
	if Globals.hour == dawn_dusk[0]:
		# sunrise
		# check the cycles against the minutes, run a cycle, then wait
		if cycles > 0:
			# check the timer and decrement
			if t_cycle > 0:
				t_cycle -= Globals.timer_ctrl * delta
			else:
				cycle(delta,0) # 0 run for sunrise
		else:
			set_season() # see if the season has changed
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
			cycles = 10 # reset cycles
			d_time = 0 # reset d_time
			check_flag = false # reset the check_flag
			t_cycle = timer_rec # reset timer_to_cycle
			cycle_timer = cTimer_rec # reset cycle_timer
	# DEBUG EXAMPLE DEBUG
	#if cycle_timer > 0:
		#cycle_timer -= Globals.timer_ctrl * delta
		#d_time += delta
		#color = DAY_COLOR.lerp(NIGHT_COLOR,sin(d_time)) # change the color


func cycle(clock, sun_direction):
	# direction 0 is day 1 is night
	if cycle_timer > 0:
		if sun_direction == 0:
			# wake up!
			cycle_timer -= Globals.timer_ctrl * clock
			d_time += clock # increment d_time
			color = NIGHT_COLOR.lerp(DAY_COLOR,sin(d_time)) # change the color
		elif sun_direction == 1:
			# go to bed!
			cycle_timer -= Globals.timer_ctrl * clock
			d_time += clock # increment d_time
			# color = DAY_COLOR.lerp(NIGHT_COLOR,sin(d_time)) # change the color
			color.r = 0.05
			color.g = 0.05
			color.b = 0.05
			print(str(color))
		else:
			# DEBUG warning message DEBUG
			print("ERROR: Direction for day/night cycle incorrectly set...")
			get_tree().quit() # exit game
	else:
		cycles -= 1 # dec cycles
		d_time = 0
		print(str(cycles))
		t_cycle = timer_rec # reset timer to cycle
		cycle_timer = cTimer_rec # reset cycle timer

func set_season():
	if !check_flag:
		if Globals.season == 0 || Globals.season == 3:
			# winter/fall
			dawn_dusk = [6,18]
			check_flag = true
		elif Globals.season == 1 || Globals.season == 2:
			# spring/summer
			dawn_dusk = [5,10]
			check_flag = true
