extends Area2D
# WOOD DOOR
# a simple wooden door that can be opened/closed and may be locked
@onready var SPRITE = $Sprite2D
@onready var AUDIO = $AudioStreamPlayer2D
@export var TITLE = "Wood Door" # the wooden door title
@export var FRAME_NO = 35 # the image frame for the door
@export var DESCRIPTION = "A simple wooden door." # the description for the door
@export var HUD_CTRL_MODE = "" # hud control mode
@export var HUD_CTRL_open = "" # hud control mode for closed doors
@export var HUD_CTRL_close = "" # hud control mode for open doors
@export var locked : bool = false # if the door is locked
@export var door_open : bool = false # if the door is open or closed
var selector_in = false # if the selector is over it
# outside scenes
var selector = null # holds the selector to update the controls


func _ready():
	# check if the door is open and then set the hud_ctrl_mode
	update_hud() # update based on editor settings

func _process(_delta):
	# check input to see if the door is being opened/closed, lock picked, locked, ect...
	if selector_in:
		if Input.is_action_just_pressed("tae_select"):
			# open/close the door if unlocked or already opened, otherwise let the player know
			# that the door is locked
			if !door_open:
				if !locked:
					AUDIO.play()
					door_open = true # open the door
					update_hud() # update the hud
				else:
					Functions.message("The door is locked...")
			else:
				AUDIO.play()
				door_open = false # close the door
				update_hud() # update the hud

func update_hud():
	# open/close the door
	if door_open:
		SPRITE.frame = 258 # open door
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		# update the HUD controls
		HUD_CTRL_MODE = HUD_CTRL_close
		if selector: selector.update_selector()
	else:
		SPRITE.frame = 256 # closed door
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		# update the HUD controls
		HUD_CTRL_MODE = HUD_CTRL_open
		if selector: selector.update_selector()

func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		selector = area.get_parent() # set selector
		selector_in = true # the selector is inside this collision2D

func _on_area_exited(area):
	if area.is_in_group("SELECTOR"):
		selector = null # reset selector
		selector_in = false # the selector is outside this collision2D
