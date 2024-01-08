extends Area2D
# WATER BARREL
# A water barrel that is open. The player can refill their waterskin (if they have one)
# or just take a straight drink. The waterskin will 'filter' it but if the player drinks straight out
# then there is a small chance they may get sick...
@export var SIGN_TITLE : String = "SIGN TITLE" # the title of the sign
@export_multiline var SIGN_TEXT : String = "SIGN TEXT" # the sign text
@export var FRAME_NO = 1
@export var DRINK_QUENCH = 0.0 # how much it quenches thirst
@export var DRINK_RISK = 0 # percentage
@export var HUD_CTRL_MODE = "" # set the hud control mode
var selector_in = false # if the selector is over this
var hit_points = 10 # has 1 hit point
var dead = false # death check * may not be needed *


func _process(_delta):
	# check input to either quench thirst or refill waterskin if the player has one
	if selector_in:
		# DRINK WATER
		if Input.is_action_just_pressed("tae_select"):
			Functions.drink_water(DRINK_QUENCH) # water barrel quenches a lot of thirst
		# REFILL WATERSKIN

func _on_area_entered(area):
	if area.is_in_group("SELECTOR"):
		selector_in = true # the selector is inside this collision2D

func _on_area_exited(_area):
	selector_in = false # the selector is outside this collision2D
