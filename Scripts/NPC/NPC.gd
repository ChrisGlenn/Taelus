extends Node
# NPC SCRIPT
# base script for the NPC's in the game
@export_enum("positive", "neutral", "negative") var attitude = "neutral" # attitue towards player (multiple factors effected)
@export var allegiance = "none" # default to none (eg. lor, skodia, gradia, king XXX, religion) 