extends Node
# CLOCK
# keeps track of seconds (by increments of 10 in game), minutes, days, years, months, seasons, ect.
# will also have a flag that is set when a new day has dawned
var active_clock = false # FALSE default
var timer_started = false # if false then activate timer and shut the flag off
var new_day = false # default FALSE will go to true if it's a new day


func _ready():
	seasons() # run the seasons function

func _process(delta):
	active_time(delta)

func active_time(_clock):
	if active_clock:
		# start the timer
		if !timer_started:
			$Timer.start()
			timer_started = true
		# set the minutes
		if Globals.seconds == 60:
			Globals.seconds = 0 # reset seconds
			# update the weather
			if !Globals.weather_updated:
				pass
				Events.weather(Globals.season, (Globals.seasonal_attribute+Globals.seasonal_weather_mod[Globals.season]))
			if Globals.minutes < 55:
				# increment the minutes by 5
				Globals.minutes += 5
			else:
				# reset the minutes and check the hours and advance the hour
				Globals.minutes = 0
				if Globals.hour < 23:
					Globals.hour += 1
					# update the weather
					#if !Globals.weather_updated:
						#Events.weather(Globals.season, Globals.seasonal_weather[Globals.season]) 
				else:
					Globals.hour = 1 # reset hours to 1
					# update the weather
					#if !Globals.weather_updated:
						#Events.weather(Globals.season, Globals.seasonal_weather[Globals.season]) 
					# month/year advance
					if Globals.day < Globals.month_max_days[Globals.month]:
						Globals.day += 1 # advance the day
						new_day = true # it's the start of a new day
					else:
						Globals.day = 1 # reset the day
						if Globals.month < 10:
							# advance the month if it's not a new year yet
							Globals.month += 1
							seasons() # run seasons function
						else:
							Globals.month = 0 # reset month
							Globals.year += 1 # advance the year
							seasons() # run seasons function
						new_day = true # it's the start of a new day
	else:
		$Timer.stop() # stop the timer
		timer_started = false # reset the timer started flag
	if new_day:
		# if it's a new day update
		new_day = false

func seasons():
	# get the month and set the season accordingly
	if Globals.month == 0:
		# Morns' Light
		Globals.season = 0 # winter
	elif Globals.month == 1:
		# Inabar's Dance
		if Globals.day >= 11:
			Globals.season = 1 # spring
		else:
			Globals.season = 0 # winter
	elif Globals.month == 2:
		# Ransfir
		Globals.season = 1 # spring
	elif Globals.month == 3:
		# Gundar's Wake
		if Globals.day >= 17:
			Globals.season = 2 # summer
		else:
			Globals.season = 1 # spring
	elif Globals.month == 4:
		# Noruv's Fire
		Globals.season = 2 # summer
	elif Globals.month == 5:
		# Sunsfir
		if Globals.day >= 20:
			Globals.season = 3 # fall
		else:
			Globals.season = 2 # summer
	elif Globals.month == 6:
		# Bloodmun
		Globals.season = 3 # fall
	elif Globals.month == 7:
		# Harvest Fall
		if Globals.day >= 18:
			Globals.season = 0 # winter
		else:
			Globals.season = 3 # fall
	else:
		Globals.season = 0 # winter

func _on_timer_timeout():
	Globals.seconds += 10
