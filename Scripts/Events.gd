extends Node
# EVENTS SCRIPT
# this script will run checks and generate 'events' that will then happen in the game
var rng = RandomNumberGenerator.new() # random number generator


func _ready():
	rng.randomize() # seed rng

func create_event():
	pass
