extends Area2D
# FARMER JOE
# An NPC test man named Farmer Joe. He is a modest farmer of a small modest farm.
# **********************
# THE PLAN
# **********************
# The farm/area 'controller' will spawn an NPC, and give it a name and family, possibly. The controller will
# then give the NPC a schedule, temperment, and other characteristics that will govern the NPC's personality.
@export_multiline var greeting_normal = ""
@export_multiline var greeting_mourning = ""
var winter_nodes = {} # winter location nodes
var spring_nodes = {} # spring location nodes
var summer_nodes = {} # summer location nodes
var fall_nodes = {} # fall location nodes
var temprement = "EASY" # EASY, AVERAGE, HARD
var state = "Still" # see documentation for NPC states...
var money = [20,0,0] # the funds for farmer joe [copper, silver, gold]
var food_stores = 80 # max 100 (gets food
var water_stores = 80 # max 100
var current_task # the current task for Farmer Joe
var move_speed = 80 # movement speed


func _ready():
	pass

func _process(_delta):
	pass

func _physics_process(_delta):
	pass
