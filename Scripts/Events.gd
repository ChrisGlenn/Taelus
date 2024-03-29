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
				if roll[1] == "LOSE":
					if roll[0] == 2:
						Globals.weather_event = "LIGHT_SNOW" # light snow
						Globals.weather = "Snowing" # update weather label
					elif roll[0] == 3:
						Globals.weather_event = "SNOW" # snow
						Globals.weather = "Snowing" # update weather label
					elif roll[0] == 4:
						Globals.weather_event = "BLIZZARD" # blizzard!!!
						Globals.weather = "Blizzard" # update weather label
					else:
						Globals.weather_event = "OVERCAST" # overcast skies
						Globals.weather = "Cloudy" # update weather label
				elif roll[1] == "EQUAL":
					Globals.weather_event = "SUN" # sunny
					Globals.weather = "Sunny" # update weather label
				elif roll[1] == "WIN":
					if roll[0] > 2:
						Globals.weather_event = "SUN" # sunny
						Globals.weather = "Sunny" # update weather label
					else:
						Globals.weather_event = "OVERCAST" # overcast skies
						Globals.weather = "Cloudy" # update weather label
				var life_roll = Dice.dice_roll(12,0)
				Globals.weather_lifespan = life_roll[0] # set lifespan of weather event
				Globals.weather_updated = true # weather is updated
			1:
				# spring
				# roll the dice with the odds to see if there will be an event
				# based on the odds set
				# SPRING means wind and various amounts of rain...
				# var roll = Dice.dice_roll(12,odds)
				var roll = [2,"LOSE"] # DEBUG used to set weather
				if roll[1] == "LOSE": 
					if roll[0] == 2:
						Globals.weather_event = "LIGHT_RAIN" # light rain
						Globals.weather = "Raining" # update weather label
					elif roll[0] == 3:
						Globals.weather_event = "RAIN" # standard rain
						Globals.weather = "Raining" # update weather label
					elif roll[0] == 4:
						Globals.weather_event = "RAIN_STORM" # rain storm
						Globals.weather = "Rain Storm" # update weather label
					else:
						Globals.weather_event = "WIND" # windy
						Globals.weather = "Windy" # update weather label
				elif roll[1] == "EQUAL":
					Globals.weather_event = "SUN" # sunny day
					Globals.weather = "Sunny" # update weather label
				elif roll[1] == "WIN":
					if roll[0] > 2:
						Globals.weather_event = "SUN" # sunny day
						Globals.weather = "Sunny" # update weather label
					else:
						Globals.weather_event = "CLOUDY" # cloudy day
						Globals.weather = "Cloudy" # update weather label
				var life_roll = Dice.dice_roll(12,0)
				Globals.weather_lifespan = life_roll[0] # set lifespan of weather event
				print(str(Globals.weather_lifespan)) # debug
				Globals.weather_updated = true # weather is updated
			2:
				# summer
				# roll the dice with the odds to see if there will be an event
				# based on the odds set
				# SUMMER means wind and heavy rain (monsoon) that's pretty much it
				var roll = Dice.dice_roll(12,odds)
				if roll[1] == "LOSE":
					if roll[0] == 3:
						Globals.weather_event = "WIND" # windy
						Globals.weather = "Windy" # update weather label
					elif roll[0] == 4:
						Globals.weather_event = "RAIN_STORM" # rain storm
						Globals.weather = "Rain Storm" # update weather label
					else:
						Globals.weather_event = "SUN" # sunny day
						Globals.weather = "Sunny" # update weather label
				elif roll[1] == "EQUAL":
					Globals.weather_event = "WIND" # sunny day
					Globals.weather = "Windy" # update weather label
				elif roll[1] == "WIN":
					if roll[0] > 2:
						Globals.weather_event = "CLOUDY" # cloudy day
						Globals.weather = "Cloudy" # update weather label
					else:
						Globals.weather_event = "SUN" # sunny again...
						Globals.weather = "Sunny" # update weather label
				var life_roll = Dice.dice_roll(12,0)
				Globals.weather_lifespan = life_roll[0] # set lifespan of weather event
				Globals.weather_updated = true # weather is updated
			3:
				# fall
				# roll the dice with the odds to see if there will be an event
				# based on the odds set
				# FALL means wind and rain, but mostly wind
				var roll = Dice.dice_roll(12,odds)
				if roll[1] == "LOSE":
					if roll[0] == 2:
						Globals.weather_event = "LIGHT_RAIN" # light rain
						Globals.weather = "Raining" # update weather label
					elif roll[0] == 3:
						Globals.weather_event = "OVERCAST" # rain storm
						Globals.weather = "Cloudy" # update weather label
					elif roll[0] == 4:
						Globals.weather_event = "RAIN_STORM" # rain storm
						Globals.weather = "Rain Storm" # update weather label
					else:
						Globals.weather_event = "WIND" # windy day
						Globals.weather = "Windy" # update weather label
				elif roll[1] == "EQUAL":
					Globals.weather_event = "SUN" # sunny again...
					Globals.weather = "Sunny" # update weather label
				elif roll[1] == "WIN":
					if roll[0] > 2:
						Globals.weather_event = "SUN" # sunny day
						Globals.weather = "Sunny" # update weather label
					else:
						Globals.weather_event = "WIND" # windy day
						Globals.weather = "Windy" # update weather label
				var life_roll = Dice.dice_roll(12,0)
				Globals.lifespan = life_roll[0] # set lifespan for weather event
				Globals.weather_updated = true # weather is updated
