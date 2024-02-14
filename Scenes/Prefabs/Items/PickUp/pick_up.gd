extends Area2D
# PICK UP ITEM
# this is the base item for anything the player can pick up
# set the relevant info and it will do the rest
@onready var SPRITE = $Sprite2D
@onready var AUDIO = $AudioStreamPlayer
@export var id = 0 # id used to make sure this item doesn't spawn twice
@export var item_owner = Area2D # the person who owns this item (will get mad if you break or steal it)
@export var item_name = "NULL" # enter the name of the item in the inventory data to pull info from from 
@export var TITLE = "HUD TITLE" # title for the hud to display
@export var DESC = "HUD DESCRIPTION" # description for the title to display
var HUD_CTRL_MODE = "" # holds hud control mode for this item
var selector_in = false # if the player's selector is in or not


func _ready():
	# setup the pickup object (frame, ect)
	HUD_CTRL_MODE = Items.Data[item_name].hud_mode
	SPRITE.frame = Items.Data[item_name].frame




#@export var Owner = Area2D
#@export var TITLE = "HUD Title" # hud title
#@export_multiline var DESCRIPTION = "HUD Description" # description
#@export var FRAME_NO = 0
#@export var HUD_CTRL_MODE = "" # set the hud control mode
#@export var item_name = "" # name of the item
#@export var item_no = 0 # defaults to 0 (null)
#@export var item_hp = 1 # defaults to 1
#@export var item_stackable = false # if true can stack in inventory
#@export var item_amount = 1 # defaults to 1
#@export_multiline var item_desc = ""
#var selector_in = false # yes if selector is in
#var picking_up = false # if true picked up will be running
#var holder_no = 0 # holds the new item index
#
#func _ready():
	#SPRITE.frame = item_no # change frame to coorespond with item no.
	#FRAME_NO = item_no # update the frame number just in case it's not set correctly
	#for n in Globals.items.size():
		#if Globals.items[n]["item"] == item_no:
			#holder_no = n # place n index into holder_no
			#break # exit the loop
#
#func _process(_delta):
	## check input while the selector is in
	#if selector_in:
		#if Input.is_action_just_pressed("tae_select"):
			## pick up the item
			#picking_up = true
		#elif Input.is_action_just_pressed("tae_mode"):
			## attack/bash the item
			#Functions.message("Attack/Bash not implemented yet...")
	## functions
	#if picking_up:
		#picked_up()
#
#func picked_up():
	## cycle through the inventory looking for a slot that either has the same item (if stackable)
	## or for a blank slot but if full will send a message that inventory is full
	#if Globals.player["inventory"].size() < 24:
		#if item_stackable:
			#if Globals.player["inventory"].size() > 0:
				#for n in Globals.player["inventory"].size():
					#if n < Globals.player["inventory"].size():
						## if the item is stackable then search for the same item in the inventory and add it
						## if it can't be found then just add the item
						#if Globals.player["inventory"][n]["item"] == item_no:
							## PLAY SOUND
							#print("Stacking!!!")
							#Globals.player["inventory"][n]["amnt"] += 1 # inc item amount
							#Functions.message(str(TITLE, " has been picked up."))
							#Globals.placed_.append(id) # record item picked up
							#Globals.selector_on = false # turn off selector for auto_off
							#queue_free() # delete self
					#else:
						## the item doesn't exist in the inventory so add it now
						## PLAY SOUND
						#print("Not stacking :(")
						#Globals.player["inventory"].append(Globals.items[holder_no])
						#Functions.message(str(TITLE, " has been picked up."))
						#Globals.placed_.append(id) # record item picked up
						#Globals.selector_on = false # turn off selector for auto_off
						#queue_free()
			#else:
				## add the item
				## PLAY SOUND
				#var new_item = Globals.items[holder_no]
				#new_item["amnt"] = item_amount
				#Globals.player["inventory"].append(new_item)
				#Functions.message(str(TITLE, " has been picked up."))
				#Globals.placed_.append(id) # record item picked up
				#Globals.selector_on = false # turn off selector for auto_off
				#queue_free() # delete self
		#else:
			## add the item
			## PLAY SOUND
			#var new_item = Globals.items[holder_no]
			#new_item["amnt"] = item_amount
			#Globals.player["inventory"].append(new_item)
			#Functions.message(str(TITLE, " has been picked up."))
			#Globals.placed_.append(id) # record item picked up
			#Globals.selector_on = false # turn off selector for auto_off
			#queue_free() # delete self
	#else:
		## inventory is full
		#Functions.message("Your inventory is full...")
		#picking_up = false

func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		selector_in = true # the selector is inside this collision2D

func _on_area_exited(area):
	if area.is_in_group("SELECTOR"):
		selector_in = false # the selector is outside this collision2D
