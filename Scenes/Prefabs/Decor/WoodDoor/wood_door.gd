extends Area2D
# WOOD DOOR
# a simple wooden door that can be opened/closed and may be locked
@onready var SPRITE = $Sprite2D
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
	if selector_in:
		if Input.is_action_just_pressed("tae_select"):
			# open the door if unlocked, otherwise let the player know
			# that the door is locked
			if !locked:
				door_open = true
			else:
				Functions.message("The door is locked...")
	# open/close the door
	if door_open:
		SPRITE.frame = 258 # open door
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
	else:
		SPRITE.frame = 256 # closed door
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)

func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		selector_in = true # the selector is inside this collision2D

func _on_area_exited(area):
	if area.is_in_group("SELECTOR"):
		selector_in = false # the selector is outside this collision2D
