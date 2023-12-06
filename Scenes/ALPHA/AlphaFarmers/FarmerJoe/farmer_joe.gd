extends Area2D
# FARMER JOE
# An NPC test man named Farmer Joe. He is a modest farmer of a small modest farm.
# **********************
# THE PLAN
# **********************
# The farm/area 'controller' will spawn an NPC, and give it a name and family, possibly. The controller will
# then give the NPC a schedule, temperment, and other characteristics that will govern the NPC's personality. 
var temprement = "EASY"
var schedule = {"winter": {},"spring": {},"summer": {},"fall": {}} # schedule dictionary
var money = [20,0,0] # the funds for farmer joe [copper, silver, gold]
var food_stores = 80 # max 100 (gets food
var water_stores = 80 # max 100
var current_task # the current task for Farmer Joe
