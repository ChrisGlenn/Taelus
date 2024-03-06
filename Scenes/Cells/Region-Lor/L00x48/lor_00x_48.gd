extends Node2D
# CELL 00X48 IN REGION LOR
@export_multiline var description = "" # used for if the player looks around

func _ready():
	Globals.current_region = "Lor" # set current region
	Globals.current_location = "Watchtower" # set current location
