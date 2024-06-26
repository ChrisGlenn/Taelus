extends Area2D
# PICK UP ITEM
# this is the base item for anything the player can pick up
# set the relevant info and it will do the rest
# EDIT to stop the pick ups from overriding each other a local item dictionary is created in each instance of 'picking up'...
@onready var SPRITE = $Sprite2D
@onready var AUDIO = $AudioStreamPlayer
@export var id = "" # id used to make sure this item doesn't spawn twice
@export var finder = "" # finder used to find the correct item in the items dictionary
@export var item_owner = Area2D # the person who owns this item (will get mad if you break or steal it)
@export var item_name = "NULL" # enter the name of the item in the inventory data to pull info from from 
@export var TITLE = "HUD TITLE" # title for the hud to display
@export_multiline var DESCRIPTION = "HUD DESCRIPTION" # description for the title to display
@export var item_amount = 0 # defaults to 1 amount of item on the ground
@export var HUD_CTRL_MODE = "pick_up" # holds hud control mode for this item
var FRAME_NO = 0 # the number of the frame for the HUD display
var selector_in = false # if the player's selector is in or not


func _ready():
	# some checks to see if this item needs to be deleted or not...
	if Globals.placed_.size() > 0:
		# check if the item has been picked up already and then delete self
		for n in Globals.placed_.size():
			if Globals.placed_[n] == id:
				queue_free()
	if item_name == "NULL":
		# ISSUE A WARNING IF AN ITEM IS NOT SET THEN DELETE SELF
		# DEBUG * enable queue_free before game goes out * DEBUG
		print("WARNING: NO ITEM SET FOR ", self)
		# queue_free()
	# setup the pickup object (frame, ect)
	SPRITE.frame = Items.items[item_name]["frame"]
	FRAME_NO = Items.items[item_name]["frame"]

func _process(_delta):
	# check input while selector is colliding
	if selector_in:
		if Input.is_action_just_pressed("tae_select"):
			# pick up the item
			picking_up()
		if Input.is_action_just_pressed("tae_mode"):
			# attack/destroy the item
			Functions.message("Attack not implemented yet!")


func picking_up():
	# cycle through the inventory looking for a slot that either has the same item (if stackable)
	# or for a blank slot but if full will send a message that the inventory is full
	if Items.items[item_name]["stackable"]:
		# if the item is stackable then see if the player has anything in their inventory
		# if not then just add the item
		if Globals.player["inventory"].size() > 0:
			# run through the player's inventory array and find a match
			# check if the max amount has been reached and if so then just append the item IF
			# there is room otherwise let the player know inventory is full
			for n in Globals.player["inventory"].size():
				if Globals.player["inventory"][n]["finder"] == finder:
					if Globals.player["inventory"][n]["amnt"] < Globals.player["inventory"][n]["max_amnt"]:
						# check if the item_amount PLUS the amount already in a slot exceeds the max(99 usually) and if so then
						# put the remainder in it's own slot...fun fun fun
						var slot_amount = Globals.player["inventory"][n]["amnt"] + item_amount
						if slot_amount > Globals.player["inventory"][n]["max_amnt"]:
							var difference = slot_amount - Globals.player["inventory"][n]["max_amnt"]
							Globals.player["inventory"][n]["amnt"] = Globals.player["inventory"][n]["max_amnt"]
							if Globals.player["inventory"].size() < 24:
								# put the item in a new slot
								var item = {
									"finder": Items.item[item_name]["finder"],
									"name" : Items.items[item_name]["name"],
									"description" : Items.items[item_name]["description"],
									"frame" : Items.items[item_name]["frame"],
									"weight" : Items.items[item_name]["weight"],
									"value" : Items.items[item_name]["value"],
									"amnt" : difference,
									"max_amnt" : Items.items[item_name]["max_amnt"],
									"min_amnt" : Items.items[item_name]["min_amnt"],
									"stackable" : Items.items[item_name]["stackable"],
									"equip" : Items.items[item_name]["equip"],
									"equipped" : Items.items[item_name]["equipped"],
									"equip_slot" : Items.items[item_name]["equip_slot"],
									"type" : Items.items[item_name]["type"],
									"hud_mode" : Items.items[item_name]["hud_mode"],
									"func_one" : Items.items[item_name]["func_one"],
									"func_two" : Items.items[item_name]["func_two"],
									"func_three" : Items.items[item_name]["func_three"]
								}
								Globals.player["inventory"].append(item) # add item to player inventory array
								Functions.message(str(TITLE, " has been picked up."))
								if Globals.selector_auto_off:
									Globals.selector_on = false # turn off selector
								queue_free() # delete item
							else:
								# there's no more room so LEAVE this pickup but change the amount to the difference
								Globals.player["inventory"][n]["amnt"] += item_amount # increment the amount
								item_amount = difference # reset this item's item amount
								Functions.message(str(TITLE, " has been picked up."))
								Globals.placed_.append(id) # record item picked up
								if Globals.selector_auto_off:
									Globals.selector_on = false # turn off selector
								break
						else:
							Globals.player["inventory"][n]["amnt"] += item_amount # increment amount
							Functions.message(str(TITLE, " has been picked up."))
							if Globals.selector_auto_off:
								Globals.selector_on = false # turn off selector
							queue_free() # delete item
							break # end loop
					else:
						# append the item to the inventory if the inventory is not full
						if Globals.player["inventory"].size() < 24:
							# PLAY SOUND HERE
							var item = {
								"finder": Items.items[item_name]["finder"],
								"name" : Items.items[item_name]["name"],
								"description" : Items.items[item_name]["description"],
								"frame" : Items.items[item_name]["frame"],
								"weight" : Items.items[item_name]["weight"],
								"value" : Items.items[item_name]["value"],
								"amnt" : item_amount,
								"max_amnt" : Items.items[item_name]["max_amnt"],
								"min_amnt" : Items.items[item_name]["min_amnt"],
								"stackable" : Items.items[item_name]["stackable"],
								"equip" : Items.items[item_name]["equip"],
								"equipped" : Items.items[item_name]["equipped"],
								"equip_slot" : Items.items[item_name]["equip_slot"],
								"type" : Items.items[item_name]["type"],
								"hud_mode" : Items.items[item_name]["hud_mode"],
								"func_one" : Items.items[item_name]["func_one"],
								"func_two" : Items.items[item_name]["func_two"],
								"func_three" : Items.items[item_name]["func_three"]
							}
							Globals.player["inventory"].append(item) # add item to player inventory array
							Globals.placed_.append(id) # record item picked up
							Functions.message(str(TITLE, " has been picked up."))
							if Globals.selector_auto_off:
								Globals.selector_on = false # turn off selector
							queue_free() # delete item
							break
						else:
							Functions.message("Your inventory is full.") # player's inventory is full
				else:
					# check if the loop is at the end of the array and hasn't found the item so just append it
					if n == Globals.player["inventory"].size()-1:
						# PLAY SOUND HERE
						var item = {
							"finder": Items.items[item_name]["finder"],
							"name" : Items.items[item_name]["name"],
							"description" : Items.items[item_name]["description"],
							"frame" : Items.items[item_name]["frame"],
							"weight" : Items.items[item_name]["weight"],
							"value" : Items.items[item_name]["value"],
							"amnt" : item_amount,
							"max_amnt" : Items.items[item_name]["max_amnt"],
							"min_amnt" : Items.items[item_name]["min_amnt"],
							"stackable" : Items.items[item_name]["stackable"],
							"equip" : Items.items[item_name]["equip"],
							"equipped" : Items.items[item_name]["equipped"],
							"equip_slot" : Items.items[item_name]["equip_slot"],
							"type" : Items.items[item_name]["type"],
							"hud_mode" : Items.items[item_name]["hud_mode"],
							"func_one" : Items.items[item_name]["func_one"],
							"func_two" : Items.items[item_name]["func_two"],
							"func_three" : Items.items[item_name]["func_three"]
						}
						Globals.player["inventory"].append(item) # add item to player inventory array
						Globals.placed_.append(id) # record item picked up
						Functions.message(str(TITLE, " has been picked up."))
						if Globals.selector_auto_off:
							Globals.selector_on = false # turn off selector
						queue_free() # delete item
						break
		else:
			# just add the item to their inventory
			# PLAY SOUND HERE
			var item = {
				"finder": Items.items[item_name]["finder"],
				"name" : Items.items[item_name]["name"],
				"description" : Items.items[item_name]["description"],
				"frame" : Items.items[item_name]["frame"],
				"weight" : Items.items[item_name]["weight"],
				"value" : Items.items[item_name]["value"],
				"amnt" : item_amount,
				"max_amnt" : Items.items[item_name]["max_amnt"],
				"min_amnt" : Items.items[item_name]["min_amnt"],
				"stackable" : Items.items[item_name]["stackable"],
				"equip" : Items.items[item_name]["equip"],
				"equipped" : Items.items[item_name]["equipped"],
				"equip_slot" : Items.items[item_name]["equip_slot"],
				"type" : Items.items[item_name]["type"],
				"hud_mode" : Items.items[item_name]["hud_mode"],
				"func_one" : Items.items[item_name]["func_one"],
				"func_two" : Items.items[item_name]["func_two"],
				"func_three" : Items.items[item_name]["func_three"]
			}
			Globals.player["inventory"].append(item) # add item to player inventory array
			Functions.message(str(TITLE, " has been picked up."))
			if Globals.selector_auto_off:
				Globals.selector_on = false # turn off selector
			queue_free() # delete item
	else:
		# item is not stackable so just pick the item up
		# PLAY SOUND HERE
		var item = {
			"finder": Items.items[item_name]["finder"],
			"name" : Items.items[item_name]["name"],
			"description" : Items.items[item_name]["description"],
			"frame" : Items.items[item_name]["frame"],
			"weight" : Items.items[item_name]["weight"],
			"value" : Items.items[item_name]["value"],
			"amnt" : item_amount,
			"max_amnt" : Items.items[item_name]["max_amnt"],
			"min_amnt" : Items.items[item_name]["min_amnt"],
			"stackable" : Items.items[item_name]["stackable"],
			"equip" : Items.items[item_name]["equip"],
			"equipped" : Items.items[item_name]["equipped"],
			"equip_slot" : Items.items[item_name]["equip_slot"],
			"type" : Items.items[item_name]["type"],
			"hud_mode" : Items.items[item_name]["hud_mode"],
			"func_one" : Items.items[item_name]["func_one"],
			"func_two" : Items.items[item_name]["func_two"],
			"func_three" : Items.items[item_name]["func_three"]
		}
		Globals.player["inventory"].append(item) # add item to player inventory array
		Globals.placed_.append(id) # record item picked up
		Functions.message(str(TITLE, " has been picked up."))
		if Globals.selector_auto_off:
			Globals.selector_on = false # turn off selector
		queue_free() # delete item


func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		selector_in = true # the selector is inside this collision2D

func _on_area_exited(area):
	if area.is_in_group("SELECTOR"):
		selector_in = false # the selector is outside this collision2D
