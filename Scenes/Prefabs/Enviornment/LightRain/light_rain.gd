extends CanvasLayer
# LIGHT RAIN
# light rain that fades in for a set amount of time and then fades out...
# this is done by using a bunch of animated sprites that are set to random start frames
# in an attempt to create rain that is far more resource friendly then a particle emitter
@onready var RAINDROP = preload("res://Scenes/Prefabs/Enviornment/Raindrop/raindrop.tscn")
@onready var DROPLET = preload("res://Scenes/Prefabs/Enviornment/RainDroplet/rain_droplet.tscn")
@onready var RAINAUDIO = $RainAudio
var stage = 0 # used to iterate through the lifecycle of light rain
var lifespan = 1 # lifespan of rain defaults to 1 for testing
var drops = 0 # the amount of drops
var drop_max = 0 # gets set randomly and used to set the max number of raindrops
var hour_check : int # keeps track of hours for lifespan



func _ready():
	hour_check = Globals.hour # set to current hour upon creation

func _process(delta):
	rain(delta) # rain function


func rain(_clock):
	# check if player is in an interior and hide the rain if so
	if Globals.interior:
		$Droplets.visible = false # hide the droplets
	else:
		if stage < 2: $Droplets.visible = true
	# RAIN
	if stage == 0:
		# fade the rain in and once it is at full 'visiblity' then start to spawn the droplets
		var droplet_one = DROPLET.instantiate()
		var droplet_two = DROPLET.instantiate()
		var droplet_three = DROPLET.instantiate()
		$Droplets.add_child(droplet_one)
		$Droplets.add_child(droplet_two)
		$Droplets.add_child(droplet_three)
		stage += 1 # advance to next stage
	elif stage == 1:
		# check for lifespan
		if lifespan > 0:
			if hour_check != Globals.hour:
				lifespan -= 1 # decrement the lifespan
				hour_check = Globals.hour # reset hour_check
		else:
			stage += 1 # advance to fade out stage
		if Input.is_action_just_pressed("tae_debug"): stage += 1
	elif stage == 2:
		# run through and delete the children droplets
		$Droplets.visible = false
		# fade out and reset weather_updated
		Globals.weather_updated = false # reset the weather updated so the weather can be updated again
		queue_free() # delete self
