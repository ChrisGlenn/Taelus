extends CanvasModulate
# THE SKY
# day/night cycle that runs for the game
# NOTE: save the color to a global for game saving???
@onready var CLOUDS = preload("res://Scenes/Prefabs/Enviornment/Clouds/clouds.tscn")
@onready var RAIN = preload("res://Scenes/Prefabs/Enviornment/Rain/rain.tscn")
@onready var WIND = preload("res://Scenes/Prefabs/Enviornment/Wind/wind.tscn")
const DAY_COLOR = Color("#ffffff") # color for the day time
const NIGHT_COLOR = Color("#0a0a0a") # color for the night time
var dawn_dusk = [6,17] # sets time for dawn dusk winter/fall: 6:00am to 5:00pm [6,17] spring/summer: 5:00 to 8:00 [5,20]
var color_tracker = 1.0 # used to update the cycle to know what to dec/inc to...
var sun_brightness = 1.0 # used to set the sun brightness
var check_flag = false # used to make checks when needed
var sky_controlled = false # if true this scene controls the weather event
var hour_check # used to make hour checks
var minute_check # used to check minutes


func _ready():
	set_season() # set the season
	# check the time that this is created and then set the visibility accordingly
	if Globals.hour == dawn_dusk[0]:
		# sun is rising
		if Globals.minutes == 0:
			set_visibility(0.1,0,0) 
			color_tracker = 0.1
		elif Globals.minutes == 5:
			set_visibility(0.2,0,0) 
			color_tracker = 0.2
		elif Globals.minutes == 10:
			set_visibility(0.3,0,0)
			color_tracker = 0.3
		elif Globals.minutes == 15:
			set_visibility(0.4,0,0)
			color_tracker = 0.4
		elif Globals.minutes == 20:
			set_visibility(0.5,0,0)
			color_tracker = 0.5
		elif Globals.minutes == 25:
			set_visibility(0.6,0,0)
			color_tracker = 0.6
		elif Globals.minutes == 30:
			set_visibility(0.7,0,0)
			color_tracker = 0.7
		elif Globals.minutes == 35:
			set_visibility(0.8,0,0)
			color_tracker = 0.8
		elif Globals.minutes == 40:
			set_visibility(0.9,0,0)
			color_tracker = 0.9
		elif Globals.minutes > 40:
			set_visibility(1.0,0,0)
			color_tracker = 1.0
	elif Globals.hour > dawn_dusk[0] and Globals.hour < dawn_dusk[1]:
		# it is daytime
		set_visibility(1,0,0)
	elif Globals.hour == dawn_dusk[1]:
		# sun is setting
		if Globals.minutes == 0:
			set_visibility(1.0,0,0)
		elif Globals.minutes == 5:
			set_visibility(0.9,0,0)
			color_tracker = 0.9
		elif Globals.minutes == 10:
			set_visibility(0.8,0,0)
			color_tracker = 0.8
		elif Globals.minutes == 15:
			set_visibility(0.7,0,0)
			color_tracker = 0.7
		elif Globals.minutes == 20:
			set_visibility(0.6,0,0)
			color_tracker = 0.6
		elif Globals.minutes == 25:
			set_visibility(0.5,0,0)
			color_tracker = 0.5
		elif Globals.minutes == 30:
			set_visibility(0.4,0,0)
			color_tracker = 0.4
		elif Globals.minutes == 35:
			set_visibility(0.3,0,0)
			color_tracker = 0.3
		elif Globals.minutes == 40:
			set_visibility(0.2,0,0)
			color_tracker = 0.2
		elif Globals.minutes == 45:
			set_visibility(0.1,0,0)
			color_tracker = 0.1
		elif Globals.minutes > 45:
			set_visibility(0.1,0,0)
			color_tracker = 0.1
	elif Globals.hour > dawn_dusk[1] and Globals.hour > dawn_dusk[0] or Globals.hour < dawn_dusk[0] and Globals.hour < dawn_dusk[1]:
		# it is nighttime
		set_visibility(0.1,0,0)
		color_tracker = 0.1

	

func _process(delta):
	# DAY/NIGHT CYCLE
	# the game starts off during the day time SO start this off looking for night...
	if Globals.hour == dawn_dusk[0]:
		# sunrise
		# run the timer, run the visibility function that checks if it's met the 'bright' criteria, if not
		# then repeat until it has
		if color.r < sun_brightness:
			if minute_check != Globals.minutes:
				color_tracker += 0.1 # increment by .1
				minute_check = Globals.minutes # reset minute check
			set_visibility(color_tracker,2,delta) # have this running
	elif Globals.hour == dawn_dusk[1]:
		# sunset
		# run the timer, run the visibility function that checks if it's met the 'dark' criteria, if not
		# then repeat until it has
		if color.r > 0.1:
			if minute_check != Globals.minutes:
				color_tracker -= 0.1 # decrement by .1
				minute_check = Globals.minutes # reset minute check
			set_visibility(color_tracker,1,delta)
	else:
		if minute_check != Globals.minutes: minute_check = Globals.minutes # reset minute check
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
			# check to see if it's daytime and if so then brighten up the skies if need be
			if Globals.hour > dawn_dusk[0+1] and Globals.hour < dawn_dusk[1-1]:
				if color.r < 1.0:
					# increment the r,g,b values
					color.r += 0.1 * delta
					color.g += 0.1 * delta
					color.b += 0.1 * delta
				else:
					Globals.weather_event = "" # set to null until next cycle
		elif Globals.weather_event == "CLOUDY":
			# check to see if it's daytime and then instantiate the clouds
			var clouds = CLOUDS.instantiate() 
			clouds.lifespan = Globals.weather_lifespan # set the clouds lifespan
			clouds.dawn_dusk = dawn_dusk # feed in the current dawn/dusk hours
			get_viewport().add_child(clouds) # add to scene
			Globals.weather_event = "" # set to null until next cycle
		elif Globals.weather_event == "LIGHT_RAIN":
			# check the time and if it's the daytime darken the skies if not already darken
			if color.r > 0.9:
				# decrement rgb values for the sky
				set_visibility(0.9,1,delta)
			else:
				# spawn the rain (time of day/night does not matter...)
				sun_brightness = 0.9 # set the sun brightness
				var rain = RAIN.instantiate()
				rain.lifespan = Globals.weather_lifespan
				rain.rain_type = "LIGHT_RAIN"
				get_parent().add_child(rain)
				Globals.weather_event = "" # null weather event
		elif Globals.weather_event == "RAIN":
			# check the time and if it's the daytime darken the skies if not already darken
			if color.r > 0.7:
				# decrement rgb values
				set_visibility(0.7,1,delta)
			else:
				# spawn the rain (time of day/night does not matter...)
				sun_brightness = 0.7 # set the sun brightness
				var rain = RAIN.instantiate()
				rain.lifespan = Globals.weather_lifespan
				rain.rain_type = "RAIN"
				get_parent().add_child(rain)
				Globals.weather_event = "" # null weather event
		elif Globals.weather_event == "RAIN_STORM":
			if color.r > 0.7:
				# decrement rgb values
				set_visibility(0.7,1,delta)
			else:
				# spawn the rain (time of day/night does not matter...)
				sun_brightness = 0.7 # set the sun brightness
				var rain = RAIN.instantiate()
				rain.lifespan = Globals.weather_lifespan
				rain.rain_type = "RAIN_STORM"
				get_parent().add_child(rain)
				Globals.weather_event = "" # null weather event
		elif Globals.weather_event == "WIND":
			# spawn the wind
			var wind = WIND.instantiate()
			get_parent().add_child(wind)
			Globals.weather_event = "" # null weather event
		elif Globals.weather_event == "OVERCAST":
			# darken the skies
			if !sky_controlled:
				if color.r > 0.8 and Globals.hour < dawn_dusk[1]:
					# decrement rgb values
					set_visibility(0.8,1,delta)
				else:
					sun_brightness = 0.8 # set the brightness to 0.8 incase day comes
					sky_controlled = true # set as true to keep track of lifespan
			else:
				if Globals.weather_lifespan > 0:
					if hour_check != Globals.hour:
						Globals.weather_lifespan -= 1 # decrement lifespan
						hour_check = Globals.hour # reset hour check
				else:
					Globals.weather_event = "" # reset weather event
					Globals.weather_updated = false # reset weather updated to spawn new event
		elif Globals.weather_event == "LIGHT_SNOW":
			# check the time and if it's the daytime darken the skies if not already darken
			if color.r > 0.8:
				# decrement rgb values for the sky
				set_visibility(0.8,1,delta)
			else:
				# spawn the light snow (time of day/night does not matter...)
				sun_brightness = 0.8 # set the sun brightness
				# SPAWN SNOW WITH LIGHT_SNOW SET
				Globals.weather_event = "" # null weather event
		elif Globals.weather_event == "SNOW":
			# check the time and if it's the daytime darken the skies if not already darken
			if color.r > 0.7:
				# decrement rgb values for the sky
				set_visibility(0.7,1,delta)
			else:
				# spawn the snow (time of day/night does not matter...)
				sun_brightness = 0.7 # set the sun brightness
				# SPAWN SNOW WITH SNOW SET
				Globals.weather_event = "" # null weather event
		elif Globals.weather_event == "BLIZZARD":
			# check the time and if it's the daytime darken the skies if not already darken
			if color.r > 0.4:
				# decrement rgb values for the sky
				set_visibility(0.4,1,delta)
			else:
				# spawn the snow (time of day/night does not matter...)
				sun_brightness = 0.4 # set the sun brightness
				# SPAWN SNOW WITH BLIZZARD SET
				Globals.weather_event = "" # null weather event
	else:
		# if the weather is done (rain is over, ect) then reset the sun brightness
		if sun_brightness != 1.0: sun_brightness = 1.0

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

func set_visibility(visibility, type, clock):
	if type == 0:
		# will instantly change the sky to set visibility
		# used to set the sky visibility when the game starts incase the player
		# loads a game during sunrise or sunset, night or day
		color.r = visibility
		color.g = visibility
		color.b = visibility
	elif type == 1:
		# darken the skies to a set number in the established array (0.1, 0.3, 0.5, 0.7, 0.9, 1)
		# then update the color_tracker
		if color.r > visibility:
			color.r -= 0.1 * clock
			color.g -= 0.1 * clock
			color.b -= 0.1 * clock
		else:
			color.r = visibility
			color.g = visibility
			color.b = visibility
			#color_tracker = visibility # set the color tracker
	elif type == 2:
		# brighten the skies to a set number (visibility)
		# then update the color_tracker
		if color.r < visibility:
			color.r += 0.1 * clock
			color.g += 0.1 * clock
			color.b += 0.1 * clock
		else:
			color.r = visibility
			color.g = visibility
			color.b = visibility
			#color_tracker = visibility # set the color tracker
