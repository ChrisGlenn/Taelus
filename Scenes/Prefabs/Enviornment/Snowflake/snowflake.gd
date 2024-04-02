extends Sprite2D
# RAIN DROPLET
# the rain droplet spawns at a random place between 128 and 640 x 360
# will animate and then hide move to another place and start over and repeat
# until the rain is over
@onready var RNG = RandomNumberGenerator.new() # RNG
var drop_type = 0 # 0 is short 1 is long
var new_location = Vector2(128, 0) # the location to move to (defaults to upper corner)
var blizzard = false # if true then enable BLIZZARD MODE!!!
var fall_speed_vert = 100.0 # vertical fall speed
var fall_speed_horiz = 50.0 # horizontal fall speed


func _ready():
	RNG.randomize() # seed random
	frame = drop_type
	global_position = Vector2(RNG.randi_range(128,640), RNG.randi_range(0,360)) # set random start position
	visible = true # show droplet

func _process(delta):
	# fall
	position.x -= fall_speed_horiz * delta
	position.y += fall_speed_vert * delta
	# reset once outside of view
	if global_position.x < get_parent().global_position.x:
		if !blizzard:
			global_position = Vector2(RNG.randi_range(200,1000), RNG.randi_range(-60,100)) # set random start position
		else:
			global_position = Vector2(RNG.randi_range(200,1800), RNG.randi_range(-60,100)) # set random start position
	elif global_position.y > 364:
		if !blizzard:
			global_position = Vector2(RNG.randi_range(200,1000), RNG.randi_range(-60,100)) # set random start position
		else:
			global_position = Vector2(RNG.randi_range(200,1800), RNG.randi_range(-60,100)) # set random start position
