extends CanvasLayer
# SNOW
# light snow that fades in for a set amount of time and then fades out...
# this is done by using a bunch of animated sprites that are set to random start frames
# in an attempt to create snow that is far more resource friendly then a particle emitter
@onready var DROPLET = preload("res://Scenes/Prefabs/Enviornment/SnowDroplet/snow_droplet.tscn")
@onready var SNOW = $ParallaxBackground/ParallaxLayer/Sprite2D
@onready var PARALLAX = $ParallaxBackground
var stage = 0 # used to iterate through the lifecycle of light snow
var lifespan = 1 # lifespan of snow defaults to 1 for testing
var droplets = [] # stores the droplets for deletion later
var hour_check : int # keeps track of hours for lifespan


func _ready():
	hour_check = Globals.hour # set to current hour upon creation
	SNOW.modulate.a = 0 # hide the snow

func _process(delta):
	snow(delta) # snow function


func snow(clock):
	# check if player is in an interior and hide the snow if so
	if Globals.interior:
		SNOW.visible = false # hide the snow
		$Droplets.visible = false # hide the droplets
	else:
		SNOW.visible = true # show the snow
		if stage < 2: $Droplets.visible = true
	# scroll the snow background
	PARALLAX.scroll_offset.x -= 34 * clock
	PARALLAX.scroll_offset.y += 64 * clock
	# snow
	if stage == 0:
		# fade the snow in and once it is at full 'visiblity' then start to spawn the droplets
		if SNOW.modulate.a < 1:
			SNOW.modulate.a += 0.4 * clock # slowly fade in
			# PLAY SOUND (increment volume here as well)
		else:
			SNOW.modulate.a = 1 # keep it from exceeding 1
			var droplet_one = DROPLET.instantiate()
			var droplet_two = DROPLET.instantiate()
			var droplet_three = DROPLET.instantiate()
			var droplet_four = DROPLET.instantiate()
			var droplet_five = DROPLET.instantiate()
			var droplet_six = DROPLET.instantiate()
			var droplet_seven = DROPLET.instantiate()
			var droplet_eight = DROPLET.instantiate()
			$Droplets.add_child(droplet_one)
			$Droplets.add_child(droplet_two)
			$Droplets.add_child(droplet_three)
			$Droplets.add_child(droplet_four)
			$Droplets.add_child(droplet_five)
			$Droplets.add_child(droplet_six)
			$Droplets.add_child(droplet_seven)
			$Droplets.add_child(droplet_eight)
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
		if SNOW.modulate.a > 0:
			SNOW.modulate.a -= 0.4 * clock # slowly fade out
		else:
			SNOW.modulate.a = 0 # stop it from going below zero
			Globals.weather_updated = false # reset the weather updated so the weather can be updated again
			queue_free() # delete self