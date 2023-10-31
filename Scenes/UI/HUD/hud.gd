extends CanvasLayer
# HUD
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


func _ready():
	# SETUP THE HUD
	# Main HUD
	NAME.text = Globals.player_name # player's name
	REGION.text = Globals.current_region + " - " + Globals.current_location # current region/location (city, area, ect...)
	REPUTATION.text = Globals.current_kingdom + ": " + Globals.player_reputations # current player reputation
	COPPER.text = str(Globals.player_copper) # copper amount
	SILVER.text = str(Globals.player_silver) # silver amount
	GOLD.text = str(Globals.player_gold) # gold amount
	STATUS.text = "Status: " + Globals.player_status # player status
	# Inventory HUD
