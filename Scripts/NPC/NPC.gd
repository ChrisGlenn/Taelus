extends Node
# NPC SCRIPT
# base script for the NPC's in the game
@export_enum("positive", "neutral", "negative") var attitude = "neutral" # attitue towards player (multiple factors effected)
@export var allegiance = "none" # default to none (eg. lor, skodia, gradia, king XXX, religion)
@export var npc_skills = [] # see documentation
@export var schedule = [] # 
@export var equipment = [] # the NPC's equipment (does not effect their look so equip accordingly)
@export var family = [] # [spouse, child, child, child...]
@export var extended_family = [] # father, mother, grandfather, grandmother, sibling, sibling...]