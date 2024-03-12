extends AnimatedSprite2D
# SNOW DROPLET
# the snow droplet spawns at a random place between 128 and 640 x 360
# will animate and then hide move to another place and start over and repeat
# until the snow is over
@onready var RNG = RandomNumberGenerator.new() # RNG
var new_location = Vector2(128, 0) # the location to move to (defaults to upper corner)
var life_timer = 120 # timer that counts down to deletion
var start_timer = 0 # timer to start the droplet (randomly generated)
var started = false # start check
var activate_timer = false # if true the timer will begin
var timer_rec # records timer


func _ready():
	RNG.randomize() # seed random
	start_timer = RNG.randi_range(20,80)
	timer_rec = life_timer # record the timer


func _process(delta):
	# start the snow droplet process
	if !started:
		if start_timer > 0:
			start_timer -= Globals.timer_ctrl * delta # decrement
		else:
			droplet() # droplet
			started = true # droplet started
	# cycle
	if activate_timer:
		if life_timer > 0:
			life_timer -= Globals.timer_ctrl * delta # decrement timer
		else:
			visible = false # hide the droplet
			droplet()
			life_timer = timer_rec # reset the timer


func droplet():
	global_position = Vector2(RNG.randi_range(128,640), RNG.randi_range(0,360)) # set random start position
	visible = true # show droplet
	play("default")


func _on_animation_finished():
	activate_timer = true # start the life_timer
