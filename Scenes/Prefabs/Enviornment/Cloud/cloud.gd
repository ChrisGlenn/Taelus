extends Sprite2D
# CLOUD
# the cloud will spawn at a random position and then move slowly downwards at an angle until offscreen
# then will respawn at a random position
@onready var RNG = RandomNumberGenerator.new()
var new_location = Vector2(128, -300) # the location to move to (defaults to upper corner)
var fall_speed = 20.0 # raindrop fall speed


func _ready():
	RNG.randomize() # seed random
	position = Vector2(RNG.randi_range(300,1000), -200) # set random start position
	visible = true # show droplet

func _process(delta):
	# fall
	position.x -= fall_speed * delta
	position.y += fall_speed * delta
	# reset once outside of view
	if global_position.x < get_parent().global_position.x - 300:
		global_position = Vector2(RNG.randi_range(300,800), -200) # set random start position
	elif global_position.y > get_parent().global_position.y + 450:
		global_position = Vector2(RNG.randi_range(300,800), -200) # set random start position
