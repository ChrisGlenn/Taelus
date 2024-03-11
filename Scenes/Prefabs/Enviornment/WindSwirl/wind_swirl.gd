extends AnimatedSprite2D
# WIND SWIRL
# wind swirl appears, animates, and then deletes itself once finished
@onready var RNG = RandomNumberGenerator.new() # RNG


func _ready():
    RNG.randomize() # seed random
    global_position = Vector2(RNG.randi_range(128,640), RNG.randi_range(0,360)) # set random start position
    visible = true # show the droplet if it's hidden
    play("default") # start the animation


func wind_swirl():
    global_position = Vector2(RNG.randi_range(128,640), RNG.randi_range(0,360)) # set random start position
    visible = true # show the droplet if it's hidden
    play("default") # start the animation


func _on_animation_finished():
    visible = false # hide swirl
    wind_swirl() # reposition and repeat
