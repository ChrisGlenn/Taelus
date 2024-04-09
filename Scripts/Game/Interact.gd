extends Node
# INTERACT
# this is a general script for interactive objects so they can all share
# this script
@export var TITLE : String = "INTERACTABLE" # the title of the sign
@export_multiline var DESCRIPTION : String = "INTERACTIVE OBJECT" # the sign text
@export var FRAME_NO = 1 # frame number
@export var HUD_CTRL_MODE = "" # set the hud control mode
@export var FUNCTION_ONE = "" # the first function
@export var FUNCTION_TWO = "" # the secont function
@export var FUNCTION_THREE = "" # the third function
var desctructable = false # if the player can destroy this item...
var hit_points = 1 # has 1 hit point
var dead = false # death check * may not be needed *