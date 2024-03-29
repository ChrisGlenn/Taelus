extends CanvasLayer
# RAIN
# rain that fades in for a set amount of time and then fades out...
# this is done by using a bunch of animated sprites that are set to random start frames
# in an attempt to create rain that is far more resource friendly then a particle emitter
@onready var RAINDROP = preload("res://Scenes/Prefabs/Enviornment/Raindrop/raindrop.tscn")
@onready var DROPLET = preload("res://Scenes/Prefabs/Enviornment/RainDroplet/rain_droplet.tscn")
@onready var RAINDROPS = $Raindrops
@onready var DROPLETS = $Droplets
@onready var RAINAUDIO = $RainAudio
var rain_to_spawn # the type of rain to spawn (small drops or large ones)
var stage = 0 # used to iterate through the lifecycle of light rain
var lifespan = 1 # lifespan of rain defaults to 1 for testing
var hour_check = 1 # keeps track of hours for lifespan (defaults to 1 for testing)
var rain_type = "LIGHT_RAIN" # the type of rain to generate
var raindrops_max = 16 # default to light_rain
var raindrops_amnt = 0 # starts at 0 then loops to max
var droplets_max = 4 # defaults to light rain
var droplets_amnt = 0 # starts at 0 then loops to max
var drop_timer = 0 # default 40


func _ready():
	hour_check = Globals.hour # set to current hour upon creation
	match rain_type:
		"LIGHT_RAIN":
			raindrops_max = 16 # set max to 12
			droplets_max = 3 # set max to 4
			rain_to_spawn = RAINDROP
		"RAIN":
			raindrops_max = 32 # set max to 24
			droplets_max = 6 # set max to 6
			rain_to_spawn = RAINDROP
		"RAIN_STORM":
			raindrops_max = 48 # set max to 36
			droplets_max = 6 # set max to 6

func _process(delta):
	raining(delta) # raining function


func raining(clock):
	# show/hide depending on player's outside/inside status
	if Globals.interior:
		RAINDROPS.visible = false # hide raindrops
		DROPLETS.visible = false # hide the droplets
	elif !Globals.interior:
		RAINDROPS.visible = true # show the raindrops
		DROPLETS.visible = true # show the droplets
	# increment through the stages until the rain is spawned, check the lifespan and then delete them
	# once it's completed...
	if stage == 0:
		# spawn the raindrops
		if drop_timer > 0:
			drop_timer -= Globals.timer_ctrl * clock
		else:
			if raindrops_amnt < raindrops_max:
				var raindrop = rain_to_spawn.instantiate()
				RAINDROPS.add_child(raindrop)
				raindrops_amnt += 1 # increment
				drop_timer = 40 # reset the timer
			else:
				stage += 1
	elif stage == 1:
		# spawn the droplets
		if droplets_amnt < droplets_max:
			var droplet = DROPLET.instantiate()
			DROPLETS.add_child(droplet)
			droplets_amnt += 1
		else:
			stage += 1