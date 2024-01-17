extends Area2D
# WOOD DOOR
# a simple wooden door that can be opened/closed and may be locked
@export var TITLE = "Wood Door" # the wooden door title
@export var FRAME_NO = 35 # the image frame for the door
@export var DESCRIPTION = "A simple wooden door." # the description for the door
@export var HUD_CTRL_MODE = "" # hud control mode
@export var locked : bool = false # if the door is locked
@export var door_open : bool = false # if the door is open or closed
var selector_in = false # if the selector is over it


func _ready():
	pass

func _process(_delta):
	# check input to see if the door is being opened/closed, lock picked, locked, ect...
	pass

func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		selector_in = true # the selector is inside this collision2D

func _on_area_exited(area):
	if area.is_in_group("SELECTOR"):
		selector_in = false # the selector is outside this collision2D
