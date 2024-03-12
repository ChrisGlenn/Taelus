extends Node2D
# CELL 00X48 IN REGION LOR
@onready var ROOF = $Roofs
@onready var BLACKOUT = $BlackOut
@export_multiline var description = "" # used for if the player looks around


func _ready():
	Globals.current_region = "Lor" # set current region
	Globals.current_location = "Watchtower" # set current location

func _process(_delta):
	# check if the player is inside of an interior (the guardtower) and then show/hide the
	# roof and blackout depending on the Globals interior status
	if Globals.interior:
		ROOF.visible = false # hide the roof
		BLACKOUT.visible = true # show the blackout
	else:
		ROOF.visible = true # show the roof
		BLACKOUT.visible = false # hide the blackout