extends CanvasLayer
# WIND
# will spawn a wind swirl every couple of seconds until it's lifespan is done
# there is also a wind sfx that will play
@onready var SWIRL = preload("res://Scenes/Prefabs/Enviornment/WindSwirl/wind_swirl.tscn")
@onready var SWIRLHOLDER = $Swirls
@onready var WINDSFX = $WindSFX
@onready var RNG = RandomNumberGenerator.new() # RNG
var lifespan = 1 # how long the wind will last (defaults to 1)
var swirl_amnt = 0 # amount of swirls to generate
var hour_check = 0 # checks against the global hours
var spawn_timer = 100 # spawn timer
var timer_rec # records spawn timer


func _ready():
	# PLAY SOUND
	RNG.randomize() # seed random
	swirl_amnt = RNG.randi_range(1,6) # set a random amount of wind swirl
	timer_rec = spawn_timer # record the spawn timer
	hour_check = Globals.hour # set the hour_check

func _process(delta):
	# iterate through the swirl_amnt spawning a swirl everytime the counter hits 0 
	# then repeating until then
	if swirl_amnt > 0:
		if spawn_timer > 0:
			spawn_timer -= Globals.timer_ctrl * delta   # decrement timer
		else:
			var swirl = SWIRL.instantiate()
			SWIRLHOLDER.add_child(swirl)
			swirl_amnt -= 1 # decrement swirl amount
			spawn_timer = timer_rec # reset timer
	# hide the swirls if the player is inside
	if Globals.interior:
		SWIRLHOLDER.visible = false # hide
	else:
		SWIRLHOLDER.visible = true # show
	# check the lifespan
	if lifespan > 0:
		if hour_check != Globals.hour:
			lifespan -= 1 # decrement lifespan
			hour_check = Globals.hour # reset hour_check
	else:
		# FADE OUT SOUND AND WHEN IT'S QUIT...
		SWIRLHOLDER.visible = false # hide the swirls
		queue_free() # delete self
