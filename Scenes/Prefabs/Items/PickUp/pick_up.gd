extends Area2D
# PICK UP ITEM
# this is the base item for anything the player can pick up
# set the relevant info and it will do the rest
@onready var SPRITE = $Sprite2D
@export var item_name = "" # name of the item
@export var item_no = 0 # defaults to 0 (null)
@export var item_hp = 1 # defaults to 1
@export var item_stackable = false # if true can stack in inventory
@export_multiline var item_desc = ""


func _ready():
	SPRITE.frame = item_no # change frame to coorespond with item no.

func picked():
	# cycle through the inventory looking for a slot that either has the same item (if stackable)
	# or for a blank slot but if full will send a message that inventory is full
	if Globals.player["inventory"].size() < 24:
		for n in Globals.player["inventory"]:
			if item_stackable:
				# if the item is stackable then search for the same item in the inventory and add it
				# if it can't be found then just add the item
				if Globals.player["inventory"][n]["item"] == item_no:
					Globals.player["inventory"][n]["amnt"] += 1 # inc item amount
					queue_free() # delete self
					break
			else:
				# add the item
				pass
	else:
		# inventory is full
		Functions.message("Your inventory is full...")
