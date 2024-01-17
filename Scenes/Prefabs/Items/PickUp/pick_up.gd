extends Area2D
# PICK UP ITEM
# this is the base item for anything the player can pick up
# set the relevant info and it will do the rest
@onready var SPRITE = $Sprite2D
@export var id = 0 # id used to make sure this item doesn't spawn twice
@export var Owner = Area2D
@export var TITLE = "HUD Title" # hud title
@export_multiline var DESCRIPTION = "HUD Description" # description
@export var FRAME_NO = 0
@export var HUD_CTRL_MODE = "" # set the hud control mode
@export var item_name = "" # name of the item
@export var item_no = 0 # defaults to 0 (null)
@export var item_hp = 1 # defaults to 1
@export var item_stackable = false # if true can stack in inventory
@export var item_amount = 1 # defaults to 1
@export_multiline var item_desc = ""
var selector_in = false # yes if selector is in
var picking_up = false # if true picked up will be running

func _ready():
	SPRITE.frame = item_no # change frame to coorespond with item no.
	FRAME_NO = item_no # update the frame number just in case it's not set correctly

func _process(_delta):
	# check input while the selector is in
	if selector_in:
		if Input.is_action_just_pressed("tae_select"):
			# pick up the item
			picking_up = true
		elif Input.is_action_just_pressed("tae_mode"):
			# attack/bash the item
			Functions.message("Attack/Bash not implemented yet...")
	# functions
	if picking_up:
		picked_up()

func picked_up():
	# cycle through the inventory looking for a slot that either has the same item (if stackable)
	# or for a blank slot but if full will send a message that inventory is full
	if Globals.player["inventory"].size() < 24:
		if item_stackable:
			if Globals.player["inventory"].size() > 0:
				for n in Globals.player["inventory"].size():
					if n < Globals.player["inventory"].size()-1:
						# if the item is stackable then search for the same item in the inventory and add it
						# if it can't be found then just add the item
						if Globals.player["inventory"][n]["item"] == item_no:
							Globals.player["inventory"][n]["amnt"] += 1 # inc item amount
							Functions.message(str(TITLE, " has been picked up."))
							Globals.placed_.append(id) # record item picked up
							queue_free() # delete self
					else:
						# the item doesn't exist in the inventory so add it now
						Globals.player["inventory"].append(Globals.items[item_no])
						Functions.message(str(TITLE, " has been picked up."))
						Globals.placed_.append(id) # record item picked up
						queue_free()
			else:
				# add the item
				var new_item = Globals.items[item_no]
				new_item["amnt"] = item_amount
				Globals.player["inventory"].append(new_item)
				Functions.message(str(TITLE, " has been picked up."))
				Globals.placed_.append(id) # record item picked up
				queue_free() # delete self
		else:
			# add the item
			var new_item = Globals.items[item_no]
			new_item["amnt"] = item_amount
			new_item["desc"] = item_desc
			Globals.player["inventory"].append(new_item)
			Functions.message(str(TITLE, " has been picked up."))
			Globals.placed_.append(id) # record item picked up
			queue_free() # delete self
	else:
		# inventory is full
		Functions.message("Your inventory is full...")
		picking_up = false

func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		selector_in = true # the selector is inside this collision2D

func _on_area_exited(area):
	if area.is_in_group("SELECTOR"):
		selector_in = false # the selector is outside this collision2D
