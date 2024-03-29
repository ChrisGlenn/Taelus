extends Sprite2D
# RAIN DROPLET
# the rain droplet spawns at a random place between 128 and 640 x 360
# will animate and then hide move to another place and start over and repeat
# until the rain is over
@onready var RNG = RandomNumberGenerator.new() # RNG
var new_location = Vector2(128, 0) # the location to move to (defaults to upper corner)
var fall_speed = 300.0 # raindrop fall speed


func _ready():
	RNG.randomize() # seed random
	global_position = Vector2(RNG.randi_range(128,640), RNG.randi_range(0,360)) # set random start position
	visible = true # show droplet

func _process(delta):
	# fall
	position.x -= fall_speed * delta
	position.y += fall_speed * delta
	# reset once outside of view
	if global_position.x < get_parent().global_position.x:
		global_position = Vector2(RNG.randi_range(200,1000), RNG.randi_range(-60,100)) # set random start position
	elif global_position.y > 364:
		global_position = Vector2(RNG.randi_range(200,1000), RNG.randi_range(-60,100)) # set random start position
