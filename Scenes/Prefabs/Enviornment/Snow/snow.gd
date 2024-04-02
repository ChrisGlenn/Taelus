extends CanvasLayer
# SNOW
# snow appears for a set amount of time and then deletes out...
# this is done by using a bunch of animated sprites that are set to random start frames
# in an attempt to create snow that is far more resource friendly then a particle emitter
@onready var SNOWFLAKE = preload("res://Scenes/Prefabs/Enviornment/Snowflake/snowflake.tscn")
@onready var DROPLET = preload("res://Scenes/Prefabs/Enviornment/SnowDroplet/snow_droplet.tscn")
@onready var SNOWFLAKES = $Snowflakes
@onready var DROPLETS = $Droplets
@onready var BLIZZAUDIO = $BlizzardAudio
var stage = 0 # used to iterate through the lifecycle of light snow
var lifespan = 1 # lifespan of snow defaults to 1 for testing
var hour_check = 1 # keeps track of hours for lifespan (defaults to 1 for testing)
var snow_type = "SNOW" # the type of snow to generate
var snow_frame = 0 # used to swap the snow sprite frame
var snowdrops_max = 16 # default to light_snow
var snowdrops_amnt = 0 # starts at 0 then loops to max
var droplets_max = 4 # defaults to light snow
var droplets_amnt = 0 # starts at 0 then loops to max
var drop_timer = 0 # default 40


func _ready():
	hour_check = Globals.hour # set to current hour upon creation
	match snow_type:
		"LIGHT_SNOW":
			snowdrops_max = 16 # set max to 12
			droplets_max = 3 # set max to 4
		"SNOW":
			snowdrops_max = 32 # set max to 24
			droplets_max = 6 # set max to 6
		"BLIZZARD":
			snowdrops_max = 64 # set max to 36
			droplets_max = 8 # set max to 6

func _process(delta):
	raining(delta) # raining function


func raining(clock):
	# show/hide depending on player's outside/inside status
	if Globals.interior:
		SNOWFLAKES.visible = false # hide raindrops
		DROPLETS.visible = false # hide the droplets
	elif !Globals.interior:
		SNOWFLAKES.visible = true # show the raindrops
		DROPLETS.visible = true # show the droplets
	# increment through the stages until the rain is spawned, check the lifespan and then delete them
	# once it's completed...
	if stage == 0:
		# spawn the raindrops
		if drop_timer > 0:
			drop_timer -= Globals.timer_ctrl * clock
		else:
			if snowdrops_amnt < snowdrops_max:
				var snowflake = SNOWFLAKE.instantiate()
				if snow_type == "SNOW":
					if snow_frame == 0:
						snowflake.drop_type = 0
						snow_frame = 1 # swap type
					else:
						snowflake.drop_type = 1
						snow_frame = 0 # swap type
				if snow_type == "BLIZZARD":
					snowflake.blizzard = true # turn on BLIZZARD MODE!!!
					snowflake.fall_speed_horiz = 420.0 # set the speed
				SNOWFLAKES.add_child(snowflake)
				snowdrops_amnt += 1 # increment
				if droplets_amnt < droplets_max:
					var droplet = DROPLET.instantiate()
					DROPLETS.add_child(droplet)
					droplets_amnt += 1
				drop_timer = 10 # reset the timer
			else:
				stage += 1
	elif stage == 1:
		# keep track of lifespan of the rain event by checking if hour_check does not equal the current hour
		if hour_check != Globals.hour:
			if lifespan > 0:
				lifespan -= 1 # decrement the weather event lifespan
				hour_check = Globals.hour # reset hour_check]
			else:
				# increment stage to stop rain
				drop_timer = 20 # reset the timer
				stage += 1
	elif stage == 2:
		# the end of the rain event
		DROPLETS.visible = false # hide the droplets
		if SNOWFLAKES.get_child_count(false) > 0:
			if drop_timer > 0:
				drop_timer -= Globals.timer_ctrl * clock
			else:
				# delete the child in position 0
				SNOWFLAKES.remove_child(SNOWFLAKES.get_child(0))
				drop_timer = 20 # reset drop timer
		else:
			Globals.weather_updated = false # reset the weather
			queue_free() # delete self
