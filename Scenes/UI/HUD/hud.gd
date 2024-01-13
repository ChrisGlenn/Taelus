extends CanvasLayer
# HUD
@onready var CONTROLS = $Controls
# message elements
# the main hud for the game
@onready var MAIN = $Main
@onready var NAME = $NameLabel
@onready var REGION = $Main/RegionLabel
@onready var DATE = $Main/DateLabel
@onready var TIME = $Main/TimeLabel
@onready var REPUTATION = $Main/ReputationLabel
@onready var COPPER = $Main/CopperLabel
@onready var SILVER = $Main/SilverLabel
@onready var GOLD = $Main/GoldLabel
@onready var STATUS = $Main/StatusLabel
# item selection hud for the game
@onready var SELECTION = $Selection
@onready var SELECTLABEL = $Selection/SelectedLabel
@onready var SELECTICON = $Selection/Selected
@onready var SELECTDESC = $Selection/SelDescriptLabel
# dialogue hud for game
@onready var DIAGHUD = $DialogueHUD
@onready var DIAGICON = $DialogueHUD/DiagIcon
@onready var DIAGDESC = $DialogueHUD/DiagDesc
@onready var DIAGBACK = $DialogueHUD/DialogueBackground
@onready var DIAGNAME = $DialogueHUD/DialogueBackground/DialogueName
@onready var DIAGTEXT = $DialogueHUD/DialogueBackground/DialogueText
# inventory hud
@onready var INVENTORY = $Inventory
@export var INVSLOTS : Array[Sprite2D] = [] # inventory slots
@onready var INVCURSOR = $Inventory/InventoryBackground/InvCursor
# hud variables
var inv_cursor_active = false # if false will be hidden
var inv_cursor_pos = 0 # corresponds with the inventory slots
var hud_control_check # keeps track of the hud control mode
var message_timer = 500 # message display timer
var timer_ctrl = 100 # timer control


func _ready():
	# set the main hude to visible and hide the others
	MAIN.visible = true
	SELECTION.visible = false
	DIAGHUD.visible = false
	# SETUP THE HUD
	# control update
	update_controls(false)
	hud_control_check = Globals.hud_control_mode # record the hud control mode
	# Main HUD
	NAME.text = Globals.player["name"] # player's name
	REGION.text = Globals.current_region + " - " + Globals.current_location # current region/location (city, area, ect...)
	DATE.text = str(Globals.day, " ", Globals.months[Globals.month], " ", Globals.year, " ", Globals.seasons[Globals.season])
	TIME.text = str(Globals.hour, ":") + str(Globals.minutes).pad_zeros(2)
	REPUTATION.text = Globals.current_kingdom + ": " + Globals.player["reputation"] # current player reputation
	COPPER.text = str(Globals.player["money"][0]) # copper amount
	SILVER.text = str(Globals.player["money"][1]) # silver amount
	GOLD.text = str(Globals.player["money"][2]) # gold amount
	STATUS.text = "Status: " + Globals.player["status"] # player status
	# Selected HUD
	# Inventory HUD
	update_inventory()

func _process(delta):
	HUD(delta) # the hud function
	inventory_cursor() # inventory cursor function

func HUD(clock):
	# check the Globals.hud_mode and act accordingly
	update_controls(true) # update the hud control map/text
	if Globals.hud_mode == "MAIN":
		# the main HUD of the game
		# shows the player the map and all the relevant info they will need to see while playing the game
		MAIN.visible = true # show the main HUD
		SELECTION.visible = false # hide the selection HUD
		DIAGHUD.visible = false # hide the dialogue HUD
		INVENTORY.visible = false # hide the inventory
		# set the hud controls
		Globals.hud_control_mode = "main"
		# update dynamic HUD elements
		DATE.text = str(Globals.day, " ", Globals.months[Globals.month], " ", Globals.year, " ", Globals.seasons[Globals.season])
		TIME.text = str(Globals.hour, ":") + str(Globals.minutes).pad_zeros(2)
		REGION.text = Globals.current_region + " - " + Globals.current_location # current region/location (city, area, ect...)
		# INPUT
		if Input.is_action_just_pressed("tae_cancel"):
			pass # PAUSE MENU GOES HERE!!!
		elif Input.is_action_just_pressed("tae_j"):
			pass # JOURNAL GOES HERE
		elif Input.is_action_just_pressed("tae_s"):
			pass # STATUS SCREEN GOES HERE
		elif Input.is_action_just_pressed("tae_i"):
			update_inventory() # refresh the inventory
			Globals.hud_mode = "INVENTORY" # change to inventory
	elif Globals.hud_mode == "SELECT":
		# When the player uses the selector to select something the information is displayed here.
		# this will also give the player a set of options they can choose to interact with the world
		MAIN.visible = false # hide the main HUD
		SELECTION.visible = true # show the selection HUD
		DIAGHUD.visible = false # hide the dialogue HUD
		INVENTORY.visible = false # hide the inventory hud
		# update the selected title, image, and description
		SELECTLABEL.text = Globals.hud_selected_name
		SELECTICON.frame = Globals.hud_sel_icon_frame
		SELECTDESC.text = Globals.hud_selected_desc
	elif Globals.hud_mode == "INVENTORY":
		# the inventory hud
		# shows the player all the items and equipment in their inventory
		Globals.can_play = false # stop player movement while inventory is open
		INVENTORY.visible = true # show the inventory 
		MAIN.visible = false # hide the main hud
		SELECTION.visible = false # hide the selection hud
		DIAGHUD.visible = false # hide the dialogue hud
		$Inventory/InventoryBackground/WeightLabel.text = str("Carrying Weight: ", Globals.player["weight"], "/", Globals.player["capacity"])
		$Inventory/EquipmentOverlay/StatusLabel.text = str("Armor Class: ", Globals.player["armor_class"], "\n", "Bonus Modifier: ", Globals.player["bonus_mod"])
		Globals.hud_control_mode = Globals.player["inventory"][inv_cursor_pos]["control"] # update the controls
		# INPUT
		# inventory cursor controls
		if Input.is_action_just_pressed("tae_right"):
			if inv_cursor_pos < Globals.player["inventory"].size() - 1 and inv_cursor_pos != 14:
				inv_cursor_pos += 1 # move right
		if Input.is_action_just_pressed("tae_left"):
			if inv_cursor_pos != 0:
				inv_cursor_pos -= 1 # move left
		if Input.is_action_just_pressed("tae_down"):
			if inv_cursor_pos + 5 < Globals.player["inventory"].size() - 1 and inv_cursor_pos < 16:
				inv_cursor_pos += 5 # move down
		# menu controls
		if Input.is_action_just_pressed("tae_cancel"):
			Globals.can_play = true # return player control
			Globals.hud_control_mode = "main" # reset controls
			Globals.hud_mode = "MAIN" # return to main menu
		elif Input.is_action_just_pressed("tae_j"):
			pass # JOURNAL GOES HERE
		elif Input.is_action_just_pressed("tae_s"):
			pass # STATUS SCREEN GOES HERE

func update_inventory():
	# update the player's inventory
	for n in INVSLOTS.size():
		# run through each slot in the inventory slots array and see if there is a corresponding item in the player inventory
		# if not then clear the slot out and revert the frame back to 0
		if Globals.player["inventory"].size() >= n + 1:
			INVSLOTS[n].frame = Globals.player["inventory"][n]["item"] # update inventory slot frame
			Globals.player["weight"] += Globals.player["inventory"][n]["weight"]
		else:
			# clear out the inventory slots
			INVSLOTS[n].frame = 0
		if Globals.player["inventory"].size() > 0:
			# set the inventory selector as active
			INVCURSOR.frame = 0
			inv_cursor_active = true
		else:
			# set the inventory selector as NOT active
			INVCURSOR.frame = 1
			inv_cursor_active = false

func inventory_cursor():
	if inv_cursor_active:
		# update the selected item display on the hud
		# also check the amount and type and update the itemamountlabel
		$Inventory/InventoryBackground/ItemLabel.text = Globals.player["inventory"][inv_cursor_pos]["name"]
		$Inventory/InventoryBackground/ItemDescription.text = Globals.player["inventory"][inv_cursor_pos]["desc"]
		$Inventory/InventoryBackground/HighlightedInv.frame = Globals.player["inventory"][inv_cursor_pos]["item"]
		if Globals.player["inventory"][inv_cursor_pos]["max_amnt"] < 99:
			$Inventory/InventoryBackground/ItemAmountLabel.text = str("Uses left: ", Globals.player["inventory"][inv_cursor_pos]["amnt"])
		else:
			$Inventory/InventoryBackground/ItemAmountLabel.text = str("Amount: ", Globals.player["inventory"][inv_cursor_pos]["amnt"])
		# $Inventory/InventoryBackground/ItemAmountLabel.text
		if Input.is_action_just_pressed("tae_debug"):
			# INVENTORY TEST (DEBUG)
			inv_cursor_pos = 0 # reset the cursor the preferred method will keep it at the spot IF it will be filled, otherwise go back one
			Globals.player["inventory"].remove_at(0) # remove item
			Globals.player["weight"] = 0 # need to remove the weight to reset it as it is now
			update_inventory() # update the inventory
		# set the cursor location
		INVCURSOR.position = Vector2(INVSLOTS[inv_cursor_pos].position.x-4, INVSLOTS[inv_cursor_pos].position.y-4)
		# inventory cursor input (equip, eat, ect.)

func update_controls(scan):
	# update the hud controls
	if !scan:
		# if scan is false then just update without checking the hud mode
		for n in Globals.hud_control:
			if Globals.hud_control[n]["mode"] == Globals.hud_control_mode:
				CONTROLS.text = Globals.hud_control[n]["controls"]
	elif scan:
		# check to see if the hud_control_mode Global has changed and if so then update the menu
		if Globals.hud_control_mode != hud_control_check:
			for n in Globals.hud_control:
				if Globals.hud_control[n]["mode"] == Globals.hud_control_mode:
					CONTROLS.text = Globals.hud_control[n]["controls"]
					hud_control_check = Globals.hud_control_mode # update the hud control check at the end of the for loop
