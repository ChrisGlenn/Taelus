extends Node
# EVENTS SCRIPT
# this script will run checks and generate 'events' that will then happen in the game
var rng = RandomNumberGenerator.new() # random number generator


func _ready():
	rng.randomize() # seed rng

func create_event():
	pass


# misc functions that require RNG
func sickness(_percentage, _sickness):
	# get the percentage of getting sick, along with a random sickness
	# and then check it against an RNG to see if the player is sick
	pass
