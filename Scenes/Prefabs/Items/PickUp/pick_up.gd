extends Area2D
# PICK UP ITEM
# this is the base item for anything the player can pick up
# set the relevant info and it will do the rest
@onready var SPRITE = $Sprite2D
@onready var AUDIO = $AudioStreamPlayer
@export var id = "" # id used to make sure this item doesn't spawn twice
@export var item_owner = Area2D # the person who owns this item (will get mad if you break or steal it)
@export var item_name = "NULL" # enter the name of the item in the inventory data to pull info from from 
@export var TITLE = "HUD TITLE" # title for the hud to display
@export_multiline var DESCRIPTION = "HUD DESCRIPTION" # description for the title to display
@export var item_amount = 1 # defaults to 1 amount of item on the ground
@export var HUD_CTRL_MODE = "pick_up" # holds hud control mode for this item
var FRAME_NO = 0 # the number of the frame for the HUD display
var selector_in = false # if the player's selector is in or not


func _ready():
	# setup the pickup object (frame, ect)
	SPRITE.frame = Items.Data[item_name].frame
	FRAME_NO = Items.Data[item_name].frame
	#
	# some checks to see if this item needs to be deleted or not...
	#
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
	if Globals.player["inventory"].size() < 24:
		if Items.Data[item_name].stackable:
			# if the item is stackable then see if the player has anything in their inventory
			# if not then just add the item
			if Globals.player["inventory"].size() > 0:
				pass
			else:
				# just add the item to their inventory
				pass
		else:
			# item is not stackable so just pick the item up
			# PLAY SOUND HERE
			Globals.player["inventory"].append(Items.Data[item_name]) # add item to player inventory array
			Globals.placed_.append(id) # record item picked up
			Functions.message(str(Items.Data[item_name].name, " has been picked up."))
			if Globals.selector_auto_off:
				Globals.selector_on = false # turn off selector
			queue_free() # delete item
	else:
		Functions.message("Inventory is full.")


func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		selector_in = true # the selector is inside this collision2D

func _on_area_exited(area):
	if area.is_in_group("SELECTOR"):
		selector_in = false # the selector is outside this collision2D
