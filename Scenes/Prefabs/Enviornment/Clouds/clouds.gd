extends CanvasLayer
# CLOUDS
# scrolling clouds that display an overcast effect
# the clouds will fade in (once the sky is visible), and then fade out before it starts to get dark
# if it's lifespan is met
@onready var CLOUDS = $CloudTexture
var stage = 0 # used to iterate through the lifecycle of light rain
var lifespan = 1 # lifespan of rain defaults to 1 for testing
var dawn_dusk = [5,17] # the dawn dusk hours
var hour_check = 1 # keeps track of hours for lifespan (defaults to 1 for testing)


func _ready():
	CLOUDS.modulate.a = 0.0 # hide the cloud sheet
	hour_check = Globals.hour # set the hour check

func _process(delta):
	clouds(delta) # cloud method


func clouds(clock):
	# check if the player is indoors and if so then hide the CLOUDS
	if Globals.interior:
		CLOUDS.visible = false
	else:
		CLOUDS.visible = true
	# check the stage and move from fading in to counting lifespan down to fading out (clearing item)
	if stage == 0:
		# fade in
		if Globals.hour > dawn_dusk[0] + 1 and Globals.hour < dawn_dusk[1] - 1:
			if CLOUDS.modulate.a < 1:
				CLOUDS.modulate.a += 0.1 * clock
			else:
				CLOUDS.modulate.a = 1 # make sure it doesn't exceed one
				stage += 1 # advance to next stage
		else:
			stage += 1 # advance to the next stage
	elif stage == 1:
		# check lifespan
		if hour_check != Globals.hour:
			if lifespan > 0:
				lifespan -= 1 # decrement lifespan if greater than 0
				hour_check = Globals.hour
			else:
				stage += 1 # else increment stage
		# keep track of dawn/dusk and then fade in or out
		if Globals.hour > dawn_dusk[0] + 1 and Globals.hour < dawn_dusk[1] - 1:
			if CLOUDS.modulate.a < 1:
				CLOUDS.modulate.a += 0.1 * clock
			else:
				CLOUDS.modulate.a = 1 # keep max at 1
		else:
			if CLOUDS.modulate.a > 0:
				CLOUDS.modulate.a -= 0.1 * clock
			else:
				CLOUDS.modulate.a = 0 # stop at 0
	elif stage == 2:
		# fade out
		if CLOUDS.modulate.a > 0:
			CLOUDS.modulate.a -= 0.1 * clock
		else:
			CLOUDS.modulate.a = 0 # zero out
			Globals.weather_updated = false # reset the weather
			queue_free() # delete self