extends Node
# FUNCTIONS FOR USE WHEN CALLED
@onready var PAUSE_MENU = preload("res://Scenes/Gameplay/PauseMenu/pause_menu.tscn")
@onready var MESSAGE = preload("res://Scenes/UI/Messages/messages.tscn")


# =============================
# SYSTEM RELATED FUNCTIONS
# =============================
func message(text):
	Globals.messages += 1 # inc messages no.	
	var new_message = MESSAGE.instantiate()
	new_message.message_text = text
	new_message.message_no = Globals.messages
	get_parent().add_child(new_message)
	if Globals.messages == 15:
		Globals.messages = -1 # reset

func pause():
	# pause the game and add a menu
	if !get_tree().paused:
		var pause_menu = PAUSE_MENU.instantiate()
		get_parent().add_child(pause_menu)
		get_tree().paused = true # pause the game

# func equip(equipment, equip_type, inv_slot):
# 	# check to see if anything is equipped and if not then equip the item
# 	# equipment is the equipment (uses the finder)
# 	# equip_type is the 'type' (armor, shield, helmet, ect.)
# 	# inv_slot is the inventory slot
# 	Globals.player[equip_type] = equipment
# 	for n in Equipment.armor.size():
# 		# find the equipment in the equipment data array
# 		if Equipment.armor[n]["finder"] == equipment:
# 			# set the armor class
# 			pass


# =============================
# PLAYER RELATED FUNCTIONS
# =============================
func set_player_modifiers():
	# run through and set the player modifiers based on their set skills
	print("Setting player modifiers...")


# =============================
# INVENTORY RELATED FUNCTIONS
# =============================
func inv_func(func_num, arg_one):
	match func_num:
		0:
			# null
			print("ERROR: FUNCTION IS 0(NULL) IN INV_FUC FOR THIS ITEM")
		1:
			# drink water
			drink_water(arg_one)
		2:
			# eat food
			print("EAT FOOD GOES HERE")
		3:
			# drink beer
			print("DRINK ALCOHOL GOES HERE")
		4:
			# empty container
			empty_container(arg_one)
		5:
			# destroy object
			print("DESTROY INVENTORY OBJECT GOES HERE")

# eating/drinking
func drink_water(quench): # (quench, risk, use)
	# restore the player's thirst by the 'quench' amount
	if quench > 0:
		Globals.player["thirst"] += quench # restore player thirst
		if Globals.player["thirst"] > 100.0: Globals.player["thirst"] = 100.0 # make sure it doesn't exceed 100
		# CALL A DICE ROLL EVENT FOR THE RISK
		# display a message
		message("You drink some water.")
	else:
		print("ERROR: QUENCH NOT SET FOR DRINK_WATER FUNCTION!!!")

func refill(container, liquid):
	# will refill a container with a liquid...
	if Globals.player["inventory"].size() > 0:
		for n in Globals.player["inventory"].size():
			if Globals.player["inventory"][n]["type"] == container:
				# refill the container
				Globals.player["inventory"][n]["amnt"] = Globals.player["inventory"][n]["max_amnt"]
				# display a message
				message(str(liquid, " has been refilled."))
				break # end loop
			if n == Globals.player["inventory"].size()-1:
				# display a failed message
				message(str("You have no ", liquid))
	else:
		# nothing in the player inventory
		message(str("You have no ", liquid))

func empty_container(container):
	# empties a container from player's inventory leaving an empty one behind
	Globals.player["inventory"][container]["amnt"] = 0
	message(str("Your empty the ", Globals.player["inventory"][container]["name"]))

func drink_alcohol(_quench, _alcohol):
	# remove some of the player's thirst and increase their alcohol intake
	# once their alcohol level reaches a certain part they are drunk
	pass

func eat_food(sustenance, _risk):
	# add the amount of sustenance to the player's hunger
	if sustenance > 0:
		Globals.player["hunger"] += sustenance
		if Globals.player["hunger"] > 100.0: Globals.player["hunger"] = 100.0 # make sure the hunger doesn't exceed 100
		# CALL AN EVENT FUNCTION FOR SICKNESS WITH THE RISK
		# display a message
	else:
		print("ERROR: SUSTENANCE NOT SET FOR EAT_FOOD FUNCTION!!!")

func drop_item(_item):
	# places the item onto the spot next to the player
	pass

func destroy_item(_item):
	# decrement/discard the item in the player's inventory
	pass
