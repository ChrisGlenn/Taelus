extends StaticBody2D
# WOOD DOOR
# a simple wooden door that can be opened/closed and may be locked
@export var door_title : String = "Wood Door" # the wooden door title
@export var image_frame : int = 35 # the image frame for the door
@export var locked : bool = false # if the door is locked
@export var description : String = "A simple wooden door." # the description for the door
@export var door_open : bool = false # if the door is open or closed


func _ready():
	pass
