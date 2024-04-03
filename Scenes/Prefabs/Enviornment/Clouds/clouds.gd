extends CanvasLayer
# CLOUDS
# scrolling clouds that display an overcast effect
# the clouds will fade in (once the sky is visible), and then fade out before it starts to get dark
# if it's lifespan is met
@onready var CLOUD = preload("res://Scenes/Prefabs/Enviornment/Cloud/cloud.tscn")
@onready var CLOUDS = $Clouds
var stage = 0 # used to iterate through the lifecycle of light rain
var lifespan = 1 # lifespan of rain defaults to 1 for testing
var hour_check = 1 # keeps track of hours for lifespan (defaults to 1 for testing)
var cloud_max = 6 # default to light_rain
var cloud_amnt = 0 # starts at 0 then loops to max
var spawn_timer = 0 # default 100


func _ready():
	hour_check = Globals.hour # set to current hour upon creation

func _process(delta):
	clouds(delta)


func clouds(clock):
	# show/hide depending on player's outside/inside status
	if Globals.interior:
		CLOUDS.visible = false # hide raindrops
	elif !Globals.interior:
		CLOUDS.visible = true # show the raindrops
	if stage == 0:
		# spawn the clouds one by one
		if spawn_timer > 0:
			spawn_timer -= Globals.timer_ctrl * clock
		else:
			if cloud_amnt < cloud_max:
				var cloud = CLOUD.instantiate()
				CLOUDS.add_child(cloud)
				cloud_amnt += 1 # increment cloud count
				spawn_timer = 600
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
				spawn_timer = 100 # reset the timer
				stage += 1
		# DEBUG
		if Input.is_action_just_pressed("tae_debug"):
			stage += 1
	elif stage == 2:
		# iterate through and turn on the 'fade_out' bool for each child cloud
		# then check if they're all gone and delete clouds and reset the weather check
		for i in CLOUDS.get_child_count(false):
			CLOUDS.get_child(i).fade_out = true
		# check if any clouds are left and if not then reset the weather check and delete self
		if CLOUDS.get_child_count(false) == 0:
			Globals.weather_updated = false # reset the weather
			queue_free() # delete self