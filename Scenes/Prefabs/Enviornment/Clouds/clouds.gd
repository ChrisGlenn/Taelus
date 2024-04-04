extends CanvasLayer
# CLOUDS
# scrolling clouds that display an overcast effect
# the clouds will fade in (once the sky is visible), and then fade out before it starts to get dark
# if it's lifespan is met
@onready var CLOUD = preload("res://Scenes/Prefabs/Enviornment/Cloud/cloud.tscn")
@onready var CLOUDS = $Clouds
var stage = 0 # used to iterate through the lifecycle of light rain
var lifespan = 1 # lifespan of rain defaults to 1 for testing
var dawn_dusk = [5,17] # the dawn dusk hours
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
	# clouds
	if hour_check > dawn_dusk[0] and hour_check < dawn_dusk[1]:
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
			# fade out the clouds through their parent CLOUDS
			if CLOUDS.modulate.a > 0:
				CLOUDS.modulate.a -= 0.2 * clock # decrement the alpha
			else:
				Globals.weather_updated = false # update weather
				queue_free() # delete self
	else:
		# if it's night time then fade out and just let the weather update
		if CLOUDS.modulate.a > 0:
			CLOUDS.modulate.a -= 0.2 * clock # decrement the alpha
		else:
			Globals.weather_updated = false # update the weather
			queue_free() # delete self