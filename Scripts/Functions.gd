extends Node
# FUNCTIONS FOR USE WHEN CALLED

# eating/drinking
func drink_water(quench): # (quench, risk, use)
	# restore the player's thirst by the 'quench' amount
	if Globals.player["thirst"] >= 100.0:
		Globals.message_on = true
		Globals.message_text = "You are not thirsty."
	else:
		if quench > 0:
			Globals.player["thirst"] += quench # restore player thirst
			if Globals.player["thirst"] > 100.0: Globals.player["thirst"] = 100.0 # make sure it doesn't exceed 100
			# CALL AN EVENT FUNCTION FOR SICKNESS WITH THE RISK
			# display a message
			Globals.message_on = true
			Globals.message_text = "You drink some water."
		else:
			print("ERROR: QUENCH NOT SET FOR DRINK_WATER FUNCTION!!!")

func refill(container, liquid):
	# will refill a container with a liquid...
	for n in Globals.player["inventory"].size():
		if Globals.player["inventory"][n]["item"] == container:
			# refill the container
			Globals.player["inventory"][n]["amnt"] = Globals.player["inventory"][n]["max_amnt"]
			# display a message
			Globals.message_on = true
			Globals.message_text = str(liquid, " has been refilled.")
			break # end loop
		if n == Globals.player["inventory"].size()-1:
			# display a failed message
			Globals.message_on = true
			Globals.message_text = str("You have no ", liquid)

func drink_alcohol(_quench, _alcohol):
	# remove some of the player's thirst and increase their alcohol intake
	# once their alcohol level reaches a certain part they are drunk
	pass

func eat_food(sustenance, _risk):
	# add the amount of sustenance to the player's hunger
	if sustenance > 0:
		Globals.player["hunger"] += sustenance
		if Globals.player["hunger"] > 100.0: Globals.player["hunger"] = 100.0 # make sure the hunger doesn't exceed 100
	else:
		print("ERROR: SUSTENANCE NOT SET FOR EAT_FOOD FUNCTION!!!")
