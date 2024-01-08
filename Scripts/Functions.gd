extends Node
# FUNCTIONS FOR USE WHEN CALLED

# eating/drinking
func drink_water(quench): # (quench, risk)
	# restore the player's thirst by the 'quench' amount
	if quench > 0:
		Globals.player["thirst"] += quench # restore player thirst
		if Globals.player["thirst"] > 100.0: Globals.player["thirst"] = 100.0 # make sure it doesn't exceed 100
		# CALL AN EVENT FUNCTION FOR SICKNESS WITH THE RISK
	else:
		print("ERROR: QUENCH NOT SET FOR DRINK_WATER FUNCTION!!!")

func refill(_container, _liquid):
	# will refill a container with a liquid...
	pass

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
