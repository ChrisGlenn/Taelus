extends AnimatedSprite2D
# RAIN DROPLET
# the rain droplet spawns at a random place between 128 and 640 x 360
# will animate and then hide move to another place and start over and repeat
# until the rain is over
@onready var RNG = RandomNumberGenerator.new() # RNG
var new_location = Vector2(128, 0) # the location to move to (defaults to upper corner)


func _ready():
    RNG.randomize() # seed random
    global_position = Vector2(RNG.randi_range(128,640), RNG.randi_range(0,360)) # set random start position
    visible = true # show droplet
    play("default")


func droplet():
    global_position = Vector2(RNG.randi_range(128,640), RNG.randi_range(0,360)) # set random start position
    visible = true # show droplet
    play("default")


func _on_animation_finished():
    visible = false # hide droplet
    droplet() # run droplet function

