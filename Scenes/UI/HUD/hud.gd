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
@onready var SELECTWRLDICON = $Selection/SelectedWrld
@onready var SELECTINVICON = $Selection/SelectedInv
@onready var SELECTDESC = $Selection/SelDescriptLabel
# dialogue hud for game
@onready var DIAGHUD = $DialogueHUD
# @onready var DIAGICON = $DialogueHUD/DiagIcon
# @onready var DIAGDESC = $DialogueHUD/DiagDesc
# @onready var DIAGBACK = $DialogueHUD/DialogueBackground
# @onready var DIAGNAME = $DialogueHUD/DialogueBackground/DialogueName
# @onready var DIAGTEXT = $DialogueHUD/DialogueBackground/DialogueText
# inventory hud
@onready var INVENTORY = $Inventory
@export var INVSLOTS : Array[Sprite2D] = [] # inventory slots
@onready var INVCURSOR = $Inventory/InventoryBackground/InvCursor
@onready var INVSTATS = $Inventory/EquipmentOverlay/StatusLabel
# inventory equipment
@onready var EQUIPARMOR = $Inventory/EquipmentOverlay/EquipArmor
var armor_equipped = {} # holds the information for the armor equipped
# status hud
@onready var STATUSMENU = $Status
@onready var STATNAME = $Status/NameStatLabel
@onready var STATGENDER = $Status/GenderStatLabel
@onready var STATRACE = $Status/RaceStatLabel
@onready var STATSTAT = $Status/StatusStatLabel
@onready var STRSTAT = $Status/StrStatLabel
@onready var AGISTAT = $Status/AgiStatLabel
@onready var ENDSTAT = $Status/EndStatLabel
@onready var INTSTAT = $Status/IntStatLabel
@onready var CHRSTAT = $Status/ChaStatLabel
@onready var REPSTAT = $Status/RepStatLabel
@onready var BOUNTYSTAT = $Status/BountyStatLabel
@onready var LOCSTAT = $Status/LocStatLabel
@onready var ACSTAT = $Status/ACStatLabel
@onready var BONUSSTAT = $Status/BModStatLabel
@onready var WEIGHTSTAT = $Status/WeightStatLabel
# hud variables
var inv_cursor_active = false # if false will be hidden
var inv_cursor_pos = 0 # corresponds with the inventory slots
var hud_control_check # keeps track of the hud control mode
var timer_ctrl = 100 # timer control


func _ready():
	# set the main hude to visible and hide the others
	MAIN.visible = true
	SELECTION.visible = false
	DIAGHUD.visible = false
	# start the clock
	Clock.active_clock = true
	# SETUP THE HUD
	# control update
	update_controls(false)
	hud_control_check = Globals.hud_control_mode # record the hud control mode
	# Main HUD
	NAME.text = Globals.player["name"] # player's name
	REGION.text = Globals.current_region + " - " + Globals.current_location # current region/location (city, area, ect...)
	DATE.text = str(Globals.day, " ", Globals.months[Globals.month], " ", Globals.year, " ", Globals.seasons[Globals.season])
	TIME.text = str(Globals.hour, ":") + str(Globals.minutes).pad_zeros(2) + " " + Globals.weather
	REPUTATION.text = Globals.current_kingdom + ": " + Globals.player["reputation"] # current player reputation
	COPPER.text = str(Globals.player["money"][0]) # copper amount
	SILVER.text = str(Globals.player["money"][1]) # silver amount
	GOLD.text = str(Globals.player["money"][2]) # gold amount
	STATUS.text = "Status: " + Globals.player["status"] # player status
	# Journal HUD
	# Inventory HUD
	update_inventory()
	# Status HUD
	update_status()

func _process(delta):
	HUD(delta) # the hud function
	inventory_cursor() # inventory cursor function
	update_location_marker()


func HUD(_clock):
	# check the Globals.hud_mode and act accordingly
	update_controls(true) # update the hud control map/text
	# ***********************************
	if Globals.hud_mode == "MAIN":
		# the main HUD of the game
		# shows the player the map and all the relevant info they will need to see while playing the game
		MAIN.visible = true # show the main HUD
		SELECTION.visible = false # hide the selection HUD
		DIAGHUD.visible = false # hide the dialogue HUD
		INVENTORY.visible = false # hide the inventory
		STATUSMENU.visible = false # hide the status menu
		# set the hud controls
		Globals.hud_control_mode = "main"
		# update dynamic HUD elements
		DATE.text = str(Globals.day, " ", Globals.months[Globals.month], " ", Globals.year, " ", Globals.seasons[Globals.season])
		TIME.text = str(Globals.hour, ":") + str(Globals.minutes).pad_zeros(2) + " " + Globals.weather
		REGION.text = Globals.current_region + " - " + Globals.current_location # current region/location (city, area, ect...)
		# INPUT
		if Globals.hud_controlable:
			if Input.is_action_just_pressed("tae_cancel"):
				pass # PAUSE MENU GOES HERE!!!
			elif Input.is_action_just_pressed("tae_j"):
				pass # JOURNAL GOES HERE
			elif Input.is_action_just_pressed("tae_s"):
				update_status() # refresh status screen
				Globals.hud_mode = "STATUS"
				get_tree().paused = true # pause the game
			elif Input.is_action_just_pressed("tae_i"):
				update_inventory() # refresh the inventory
				Globals.hud_mode = "INVENTORY" # change to inventory
				get_tree().paused = true # pause the game
	# ***********************************
	elif Globals.hud_mode == "SELECT":
		# When the player uses the selector to select something the information is displayed here.
		# this will also give the player a set of options they can choose to interact with the world
		# =========================================================================
		# check if this is a pick-up item or not and set the visibilty on the icons
		if Globals.hud_control_mode == "pick_up":
			SELECTINVICON.visible = true # show
			SELECTWRLDICON.visible = false # hide
		else:
			SELECTWRLDICON.visible = true # show
			SELECTINVICON.visible = false # hide
		MAIN.visible = false # hide the main HUD
		SELECTION.visible = true # show the selection HUD
		DIAGHUD.visible = false # hide the dialogue HUD
		INVENTORY.visible = false # hide the inventory hud
		# update the selected title, image, and description
		SELECTLABEL.text = Globals.hud_selected_name
		SELECTWRLDICON.frame = Globals.hud_sel_icon_frame
		SELECTINVICON.frame = Globals.hud_sel_icon_frame
		SELECTDESC.text = Globals.hud_selected_desc
	# ***********************************
	elif Globals.hud_mode == "INVENTORY":
		# the inventory hud
		# shows the player all the items and equipment in their inventory
		INVENTORY.visible = true # show the inventory 
		MAIN.visible = false # hide the main hud
		SELECTION.visible = false # hide the selection hud
		DIAGHUD.visible = false # hide the dialogue hud
		$Inventory/InventoryBackground/WeightLabel.text = str("Carrying Weight: ", Globals.player["weight"], "/", Globals.player["capacity"])
		$Inventory/EquipmentOverlay/StatusLabel.text = str("Armor Class: ", Globals.player["armor_class"], "\n", "Bonus Modifier: ", Globals.player["bonus_mod"])
		if Globals.player["inventory"].size() > 0:
			Globals.hud_control_mode = Globals.player["inventory"][inv_cursor_pos]["hud_mode"] # update the controls
		else:
			Globals.hud_control_mode = "return"
		# INVENTORY INPUT
		if Input.is_action_just_pressed("tae_right"):
			if inv_cursor_pos < Globals.player["inventory"].size() - 1 and inv_cursor_pos != 14:
				inv_cursor_pos += 1 # move right
		if Input.is_action_just_pressed("tae_left"):
			if inv_cursor_pos != 0:
				inv_cursor_pos -= 1 # move left
		if Input.is_action_just_pressed("tae_down"):
			if inv_cursor_pos + 5 < Globals.player["inventory"].size() - 1 and inv_cursor_pos < 16:
				inv_cursor_pos += 5 # move down
		if Input.is_action_just_pressed("tae_select"):
			# FIRST FUNCTION
			# check what kind of item is in the inventory then run the first function feeding in parameters as needed
			if Globals.player["inventory"].size() > 0:
				if Globals.player["inventory"][inv_cursor_pos]["type"] == "NULL":
					# no type is set on said inventory item
					print("ERROR: NO TYPE SET FOR ITEM...")
					get_tree().quit() # exit game
				elif Globals.player["inventory"][inv_cursor_pos]["type"] == "CONSUME":
					if Globals.player["inventory"][inv_cursor_pos]["amnt"] > 0:
						Functions.inv_func(Globals.player["inventory"][inv_cursor_pos]["func_one"][0], Globals.player["inventory"][inv_cursor_pos]["func_one"][1])
						Globals.player["inventory"][inv_cursor_pos]["amnt"] -= 1
						if Globals.player["inventory"][inv_cursor_pos]["min_amnt"] == 0 and Globals.player["inventory"][inv_cursor_pos]["amnt"] == 0:
							Globals.player["inventory"].remove_at(inv_cursor_pos)
					else:
						Functions.message(str(Globals.player["inventory"][inv_cursor_pos]["name"], " is empty."))
				elif Globals.player["inventory"][inv_cursor_pos]["type"] == "EQUIP":
					if Globals.player["inventory"][inv_cursor_pos]["hud_mode"] == "sel_equip":
						# equip the armor by running Functions.equip
						#Functions.equip(Globals.player["inventory"][inv_cursor_pos]["finder"], Globals.player["inventory"][inv_cursor_pos]["equip_slot"], Globals.player["inventory"][inv_cursor_pos])
						update_inventory() # update the inventory
		if Input.is_action_just_pressed("tae_mode"):
			# SECOND FUNCTION
			# check what kind of item is in the inventory then run the first function feeding in parameters as needed
			if Globals.player["inventory"].size() > 0:
				Functions.inv_func(Globals.player["inventory"][inv_cursor_pos]["func_two"][0], inv_cursor_pos)
		# MENU INPUT
		if Input.is_action_just_pressed("tae_cancel"):
			Globals.hud_control_mode = "main" # reset controls
			Globals.hud_mode = "MAIN" # return to main menu
			get_tree().paused = false # unpause
		elif Input.is_action_just_pressed("tae_j"):
			pass # JOURNAL GOES HERE
		elif Input.is_action_just_pressed("tae_s"):
			pass # STATUS SCREEN GOES HERE
	# ***********************************
	elif Globals.hud_mode == "DIALOGUE":
		pass
	# ***********************************
	elif Globals.hud_mode == "STATUS":
		Globals.hud_control_mode = "paused" # set the hud control mode
		STATUSMENU.visible = true # show the status screen
		# controls
		if Input.is_action_just_pressed("tae_cancel"):
			Globals.hud_mode = "MAIN" # return to main menu
			Globals.hud_control_mode = "main" # reset controls
			get_tree().paused = false # unpause game

func update_inventory():
	# update the player's inventory
	for n in INVSLOTS.size():
		# run through each slot in the inventory slots array and see if there is a corresponding item in the player inventory
		# if not then clear the slot out and revert the frame back to 0
		if Globals.player["inventory"].size() >= n + 1:
			INVSLOTS[n].frame = Globals.player["inventory"][n]["frame"] # update inventory slot frame
			# update the inventory 'E' equipped symbol
			if Globals.player["inventory"][n]["equipped"]:
				var current_slot = INVSLOTS[n].get_child(false)
				current_slot.visible = true
			else:
				var current_slot = INVSLOTS[n].get_child(false)
				current_slot.visible = false
			Globals.player["weight"] += Globals.player["inventory"][n]["weight"] # FIX THIS DEBUG DEBUG DEBUG
		else:
			# clear out the inventory slots
			INVSLOTS[n].frame = 0
		if Globals.player["inventory"].size() > 0:
			# set the inventory selector as active
			INVCURSOR.frame = 0
			inv_cursor_active = true
		else:
			# set the inventory selector as NOT active
			Globals.player["weight"] = 0 # reset the player carrying weight
			INVCURSOR.frame = 1
			inv_cursor_active = false
	# EQUIPMENT UPDATE
	# update the equipment overlays
	# update the armor class stat
	INVSTATS = str("Armor Class: ", Globals.player["armor_class"], "\nBonus Modifier: ", Globals.player["bonus_mod"])

func inventory_cursor():
	if inv_cursor_active:
		if Globals.player["inventory"].size() > 0:
			# update the selected item display on the hud
			# also check the amount and type and update the itemamountlabel
			$Inventory/InventoryBackground/ItemLabel.text = Globals.player["inventory"][inv_cursor_pos]["name"]
			$Inventory/InventoryBackground/ItemDescription.text = Globals.player["inventory"][inv_cursor_pos]["description"]
			$Inventory/InventoryBackground/HighlightedInv.frame = Globals.player["inventory"][inv_cursor_pos]["frame"]
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
		else:
			# inv_cursor_active becomes false if the player's inventory becomes empty
			# reset the HUD elements
			$Inventory/InventoryBackground/ItemLabel.text = ""
			$Inventory/InventoryBackground/ItemDescription.text = ""
			$Inventory/InventoryBackground/HighlightedInv.frame = 0
			$Inventory/InventoryBackground/ItemAmountLabel.text = ""
			update_inventory() # clear inventory
			INVCURSOR.frame = 1
			inv_cursor_active = false

func equip():
	pass

func update_status():
	# update the status information
	STATNAME.text = Globals.player["name"] # set the player name
	STATGENDER.text = str("Gender: ", Globals.player["gender"]) # set player gender
	STATRACE.text = str("Race: ", Globals.races[Globals.player["race"]]) # set player race
	STATSTAT.text = str("Status: ", Globals.player["status"]) # set player status
	STRSTAT.text = str("Strength: ", Globals.player["strength"]) # set player strength
	AGISTAT.text = str("Agility: ", Globals.player["agility"]) # set player agility
	ENDSTAT.text = str("Endurance: ", Globals.player["endurance"]) # set player endurance
	INTSTAT.text = str("Intelligence: ", Globals.player["intelligence"]) # set player intelligence
	CHRSTAT.text = str("Charisma: ", Globals.player["charisma"]) # set player charisma
	REPSTAT.text = str("Reputation: ", Globals.player["reputation"]) # set player reputation
	BOUNTYSTAT.text = str("Bounty: ", Globals.player["bounty"]) # set player bounty
	LOCSTAT.text = str("Location: ", Globals.current_location) # set current location
	ACSTAT.text = str("Armor Class: ", Globals.player["armor_class"]) # set player armor class
	BONUSSTAT.text = str("Bonus Mod: ", Globals.player["bonus_mod"]) # set player bonus mod
	WEIGHTSTAT.text = str("Carrying Weight/Capacity: ", Globals.player["weight"], "/", Globals.player["capacity"]) # set player weight/capacity

func update_location_marker():
	if Globals.location_marker_dir > -4:
		match Globals.location_marker_dir:
			0:
				# up
				$Main/LocationMarker.global_position.y -= 2
				Globals.location_marker_dir = -4
			1:
				# right
				$Main/LocationMarker.global_position.x += 2
				Globals.location_marker_dir = -4
			2:
				# down
				$Main/LocationMarker.global_position.y += 2
				Globals.location_marker_dir = -4
			3:
				# left
				$Main/LocationMarker.global_position.x -= 2
				Globals.location_marker_dir = -4

func update_controls(scan):
	# update the hud controls
	if !scan:
		# if scan is false then just update without checking the hud mode
		for n in Globals.hud_control.size():
			if Globals.hud_control[n]["mode"] == Globals.hud_control_mode:
				CONTROLS.text = Globals.hud_control[n]["controls"]
	elif scan:
		# check to see if the hud_control_mode Global has changed and if so then update the menu
		if Globals.hud_control_mode != hud_control_check:
			for n in Globals.hud_control.size():
				if Globals.hud_control[n]["mode"] == Globals.hud_control_mode:
					CONTROLS.text = Globals.hud_control[n]["controls"]
					hud_control_check = Globals.hud_control_mode # update the hud control check at the end of the for loop
