extends CanvasLayer
# LIGHT RAIN
# light rain that fades in for a set amount of time and then fades out...
# this is done by using a bunch of animated sprites that are set to random start frames
# in an attempt to create rain that is far more resource friendly then a particle emitter
# SOUND GOES HERE
@onready var DROPLET = preload("res://Scenes/Prefabs/Enviornment/RainDroplet/rain_droplet.tscn")
@onready var RAINAUDIO = $RainAudio
@onready var LIGHTRAIN = $ParallaxBackground/ParallaxLayer/Sprite2D
@onready var PARALLAX = $ParallaxBackground
@onready var SKIES = $Skies
var stage = 0 # used to iterate through the lifecycle of light rain
var lifespan = 1 # lifespan of rain defaults to 1 for testing
var droplets = [] # stores the droplets for deletion later
var hour_check : int # keeps track of hours for lifespan



func _ready():
	hour_check = Globals.hour # set to current hour upon creation
	LIGHTRAIN.modulate.a = 0 # hide the rain
	SKIES.modulate.a = 0 # make sure skies are clear

func _process(delta):
	rain(delta) # rain function


func rain(clock):
	# scroll the rain background
	PARALLAX.scroll_offset.x -= 180 * clock
	PARALLAX.scroll_offset.y += 180 * clock
	# RAIN
	if stage == 0:
		# check the current time and if it's night or becoming night then don't modulate
		# darken the skies before starting the rainfall
		if SKIES.modulate.a < 0.2:
			SKIES.modulate.a += 0.1 * clock
		else:
			SKIES.modulate.a = 0.2
			stage += 1 # advance to next stage
	elif stage == 1:
		# fade the rain in and once it is at full 'visiblity' then start to spawn the droplets
		if LIGHTRAIN.modulate.a < 1:
			LIGHTRAIN.modulate.a += 0.4 * clock # slowly fade in
			# PLAY SOUND (increment volume here as well)
		else:
			LIGHTRAIN.modulate.a = 1 # keep it from exceeding 1
			var droplet_one = DROPLET.instantiate()
			var droplet_two = DROPLET.instantiate()
			var droplet_three = DROPLET.instantiate()
			var droplet_four = DROPLET.instantiate()
			var droplet_five = DROPLET.instantiate()
			$Droplets.add_child(droplet_one)
			$Droplets.add_child(droplet_two)
			$Droplets.add_child(droplet_three)
			$Droplets.add_child(droplet_four)
			$Droplets.add_child(droplet_five)
			stage += 1 # advance to next stage
	elif stage == 2:
		# check for lifespan
		if lifespan > 0:
			if hour_check != Globals.hour:
				lifespan -= 1 # decrement the lifespan
				hour_check = Globals.hour # reset hour_check
		else:
			stage += 1 # advance to fade out stage
		if Input.is_action_just_pressed("tae_debug"): stage += 1
	elif stage == 3:
		# run through and delete the children droplets
		$Droplets.visible = false
		# fade out and reset weather_updated
		if LIGHTRAIN.modulate.a > 0:
			LIGHTRAIN.modulate.a -= 0.4 * clock # slowly fade out
		else:
			LIGHTRAIN.modulate.a = 0 # stop it from going below zero
			Globals.weather_updated = false # reset the weather updated so the weather can be updated again
			queue_free() # delete self
