extends CanvasLayer
# LIGHT RAIN
# light rain that fades in for a set amount of time and then fades out...
# this is done by using a bunch of animated sprites that are set to random start frames
# in an attempt to create rain that is far more resource friendly then a particle emitter
# SOUND GOES HERE
@onready var RAINAUDIO = $RainAudio
@onready var RNG = RandomNumberGenerator.new() # random number generator
var rain_set = false # if true all drops have had a frame set and animation started
var lifespan = 2 # the life of the rain to bet set by event (defaults to 2 for testing)
var hour_check # gets set to the current hour and used to check
var life_end = false # if true then after the fade out this will delete self
var drops = [] # holds the rain drops
var rain_timer = 16 # timer to display rain drops
var timer_rec # records the rain_timer


func _ready():
	hour_check = Globals.hour # set the hour check to current hour
	timer_rec = rain_timer
	RNG.randomize() # seed random
	# for loop to set the random start frame for each rain drop
	# also starts the rain drop animation
	for n in $Rain.get_children():
		n.frame = RNG.randi_range(0,13)
		n.play("default")
		drops.append(n)

func _process(delta):
	rain(delta) # rain function


func rain(clock):
	# if the player is inside of a building then 'hide' the rain
	if Globals.interior:
		$Rain.visible = false # hide all the rain drops
	else:
		$Rain.visible = true # otherwise show the raindrops
	# if the drops array actually has some drops in it then run through the timer and
	# then make the drops in a random location visible, and reset the timer
	if drops.size() > 0:
		if rain_timer > 0:
			rain_timer -= Globals.timer_ctrl * clock
		else:
			var show_drop = RNG.randi_range(0, drops.size()-1)
			drops[show_drop].visible = true
			drops.remove_at(show_drop)
			rain_timer = timer_rec
	# update the lifespan
	if !life_end:
		if lifespan > 0:
			# check if the Globals.hour has not changed
			if Globals.hour != hour_check:
				lifespan -= 1 # decrement lifespan
				hour_check = Globals.hour # reset hour_check
		else:
			pass
