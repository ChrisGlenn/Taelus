extends CanvasLayer
# HUD
@onready var CONTROLS = $Controls
# the main hud for the game
@onready var MAIN = $Main
@onready var NAME = $NameLabel
@onready var REGION = $Main/RegionLabel
@onready var DATE = $Main/DateTimeLabel
@onready var REPUTATION = $Main/ReputationLabel
@onready var COPPER = $Main/CopperLabel
@onready var SILVER = $Main/SilverLabel
@onready var GOLD = $Main/GoldLabel
@onready var STATUS = $Main/StatusLabel
# item selection hud for the game
@onready var SELECTION = $Selection
@onready var SELECTLABEL = $Selection/SelectedLabel
@onready var SELECTICON = $Selection/Selected
@onready var SELECTSTAT = $Selection/SelectStatLabel
# dialogue hud for game
@onready var DIAGHUD = $DialogueHUD
@onready var DIAGICON = $DialogueHUD/DiagIcon
@onready var DIAGDESC = $DialogueHUD/DiagDesc
@onready var DIAGBACK = $DialogueHUD/DialogueBackground
@onready var DIAGNAME = $DialogueHUD/DialogueBackground/DialogueName
@onready var DIAGTEXT = $DialogueHUD/DialogueBackground/DialogueText
# hud variables
var hud_mode = "MAIN"


func _ready():
	# SETUP THE HUD
	CONTROLS.text = Globals.hud_controls_main
	# Main HUD
	NAME.text = Globals.player_name # player's name
	REGION.text = Globals.current_region + " - " + Globals.current_location # current region/location (city, area, ect...)
	REPUTATION.text = Globals.current_kingdom + ": " + Globals.player_reputations # current player reputation
	COPPER.text = str(Globals.player_copper) # copper amount
	SILVER.text = str(Globals.player_silver) # silver amount
	GOLD.text = str(Globals.player_gold) # gold amount
	STATUS.text = "Status: " + Globals.player_status # player status
	# Inventory HUD

func _process(_delta):
	pass

func HUD():
	# set the main hude to visible and hide the others
	MAIN.visible = true
	SELECTION.visible = false
	DIAGHUD.visible = false
