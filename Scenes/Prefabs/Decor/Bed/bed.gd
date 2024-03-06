extends Area2D
# BED
# a bed where the player can sleep and recover some HP
# if the bed is owned by someone else the player can still sleep in it BUT
# if the owner is around they will react based on their temperment...
@export var TITLE = "HUD TITLE" # title for the hud to display
@export_multiline var DESCRIPTION = "HUD DESCRIPTION" # description for the title to display
@export var HUD_CTRL_MODE = "sel_bed" # holds hud control mode for this item
@export var FRAME_NO = 0 # the number of the frame for the HUD display
var selector_in = false # turns on if the player selector is in


func _ready():
    pass

func _process(_delta):
    pass


func _on_area_exited(area):
    if area.is_in_group("SELECTOR"):
        selector_in = false # the selector has left

func _on_area_entered(area):
    if area.is_in_group("SELECTOR"):
        selector_in = true # the selector has entered
