extends CanvasLayer
# WEATHER PARTICLES
# this scene controls particle based weather systems (rain, snow, wind)
# it will slowly increment the particle amount over time until the max is reached
# then wait until it's done and decrement until 0 and then deletes itself
@onready var RAINPART = $Rain
@onready var HRAINPART = $HeavyRain
@onready var HSNOWPART = $HeavySnow
var event_type = "RAIN" # gets the even type and then creates the event based off of it
var lifespan = 1 # counted in hours
var end_timer = 100 # timer to delete self so rain doesn't abruptly disappear
var hour_rec = 0 # used to keep track of passed hours in game


func _ready():
	hour_rec = Globals.hour # record initial hour

func _process(delta):
	# get the weather event type and then start/stop the applicable particle emitter
	# check the lifespan against the current hour and update accordingly
	# hour check
	if event_type == "LIGHT_RAIN":
		if lifespan > 0:
			# slowly increment the particle emitter amount
			RAINPART.amount = 64 # set the amount of rain particles to show
			RAINPART.emitting = true # start the emission
			# if the lifespan isn't 0 then decrement it
			if hour_rec != Globals.hour:
				lifespan -= 1 # decrement lifespan
				hour_rec = Globals.hour # update hour
		else:
			# who will stop the rain? I'll stop the rain!
			RAINPART.emitting = false # stop the rain
			if end_timer > 0:
				end_timer -= Globals.timer_ctrl * delta
			else:
				Globals.weather_updated = false # reset the weather
				queue_free() # delete self