extends CanvasLayer
# HUD
@onready var CONTROLS = $Controls
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
@export var INVSLOTS = []
# hud variables


func _ready():
	# set the main hude to visible and hide the others
	MAIN.visible = true
	SELECTION.visible = false
	DIAGHUD.visible = false
	# SETUP THE HUD
	CONTROLS.text = Globals.hud_controls
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

func _process(_delta):
	HUD() # the hud function

func HUD():
	# check the Globals.hud_mode and act accordingly
	if Globals.hud_mode == "MAIN":
		# the main HUD of the game
		# shows the player the map and all the relevant info they will need to see while playing the game
		MAIN.visible = true # show the main HUD
		SELECTION.visible = false # hide the selection HUD
		DIAGHUD.visible = false # hide the dialogue HUD
		INVENTORY.visible = false # hide the inventory
		# update dynamic HUD elements
		DATE.text = str(Globals.day, " ", Globals.months[Globals.month], " ", Globals.year, " ", Globals.seasons[Globals.season])
		TIME.text = str(Globals.hour, ":") + str(Globals.minutes).pad_zeros(2)
		REGION.text = Globals.current_region + " - " + Globals.current_location # current region/location (city, area, ect...)
		Globals.hud_controls = "ESC = Menu\nJ = Journal\n S = Status I = Inventory\n CTRL = Interact"
		CONTROLS.text = Globals.hud_controls
		# INPUT
		if Input.is_action_just_pressed("tae_cancel"):
			pass # PAUSE MENU GOES HERE!!!
		elif Input.is_action_just_pressed("tae_j"):
			pass # JOURNAL GOES HERE
		elif Input.is_action_just_pressed("tae_s"):
			pass # STATUS SCREEN GOES HERE
		elif Input.is_action_just_pressed("tae_i"):
			pass # INVENTORY GOES HERE
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
		INVENTORY.visible = true # show the inventory 
		MAIN.visible = false # hide the main hud
		SELECTION.visible = false # hide the selection hud
		DIAGHUD.visible = false # hide the dialogue hud

func update_inventory():
	# update the player's inventory
	for n in Globals.player["inventory"].size():
		match Globals.player["inventory"][n]:
			0:
				# null
				print(INVSLOTS[n])

