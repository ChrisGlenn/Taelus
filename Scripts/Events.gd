extends Node
# EVENTS
# this holds the functions that create events in the game!!!


func weather(season, odds):
	# season = current season
	# odds[seasonal_odds] = the odds set for the current year
	# effect = rain, snow, wind, sun
	# this function updates the weather using a 12 sided die roll
	# it takes in some parameters then does a 'dice roll' which will return a number
	# then updates the Globals for the Sky.tscn scene to read and update
	if !Globals.weather_updated:
		# if the weather isn't updated then run the event
		match season:
			0:
				# winter
				# roll the dice with the odds to see if there will be an event
				# based on the odds set
				# WINTER means snow...lots of snow
				var roll = Dice.dice_roll(12,odds)
				if roll[0] > 0: 
					Globals.weather_event = "LIGHT_SNOW" # just a light snow
				elif roll[0] >= 2:
					Globals.weather_event = "SNOW" # regular snow
				elif roll[0] >= 4:
					Globals.weather_event = "HEAVY_SNOW" # heavy snow
				elif roll[0] >= 5:
					Globals.weather_event = "SNOW_STORM" # blizzard
				print(Globals.weather_event) # DEBUG print the weather
				Globals.weather_updated = true # weather is updated
			1:
				# spring
				# roll the dice with the odds to see if there will be an event
				# based on the odds set
				# SPRING means wind and various amounts of rain...
				#var roll = Dice.dice_roll(12,odds)
				var roll = [1,"LOSE"]
				if roll[1] == "LOSE": 
					if roll[0] == 2:
						Globals.weather_event = "LIGHT_RAIN" # regular rain
					elif roll[0] == 3:
						Globals.weather_event = "RAIN" # standard rain
					elif roll[0] == 4:
						Globals.weather_event = "RAIN_STORM" # rain storm
					else:
						Globals.weather_event = "WIND" # windy
				elif roll[1] == "EQUAL":
					Globals.weather_event = "SUN" # sunny day
				else:
					if roll[0] > 2:
						Globals.weather_event = "SUN" # sunny day
					else:
						Globals.weather_event = "CLOUDY" # cloudy day
				Globals.weather_lifespan = 2
				print(Globals.weather_event) # DEBUG print the weather
				print(str(Globals.weather_lifespan))
				print(str(roll))
				Globals.weather_updated = true # weather is updated
			2:
				# summer
				# roll the dice with the odds to see if there will be an event
				# based on the odds set
				# SUMMER means wind and heavy rain (monsoon) that's pretty much it
				var roll = Dice.dice_roll(12,odds)
				if roll[0] >= 3:
					Globals.weather_event = "WIND" # some wind
				elif roll[0] >= 4:
					Globals.weather_event = "HEAVY_WIND" # heavy wind
				elif roll[0] >= 5:
					Globals.weather_event = "RAIN_STORM" # rain storm
				print(Globals.weather_event) # DEBUG print the weather
				Globals.weather_updated = true # weather is updated
			3:
				# fall
				# roll the dice with the odds to see if there will be an event
				# based on the odds set
				# FALL means wind and rain, but mostly wind
				var roll = Dice.dice_roll(12,odds)
				if roll[0] >= 3:
					Globals.weather_event = "WIND" # some wind
				elif roll[0] >= 5:
					Globals.weather_event = "HEAVY_WIND" # heavy wind
				print(Globals.weather_event) # DEBUG print the weather
				Globals.weather_updated = true # weather is updated
