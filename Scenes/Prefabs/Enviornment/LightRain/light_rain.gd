extends CanvasLayer
# LIGHT RAIN
# light rain that fades in for a set amount of time and then fades out...
# this is done by using a bunch of animated sprites that are set to random start frames
# in an attempt to create rain that is far more resource friendly then a particle emitter
@onready var RNG = RandomNumberGenerator.new() # random number generator
var rain_set = false # if true all drops have had a frame set and animation started
var drop_frame = 0


func _ready():
    RNG.randomize() # seed random

func _process(_delta):
    if !rain_set:
        # one
        drop_frame = RNG.randi_range(0,14)
        $RainDrops.frame = drop_frame
        $RainDrops.play("default")
        # two
        drop_frame = RNG.randi_range(0,14)
        $RainDrops2.frame = drop_frame
        $RainDrops2.play("default")
        # three
        drop_frame = RNG.randi_range(0,14)
        $RainDrops3.frame = drop_frame
        $RainDrops3.play("default")
        # four
        drop_frame = RNG.randi_range(0,14)
        $RainDrops4.frame = drop_frame
        $RainDrops4.play("default")
        # three
        drop_frame = RNG.randi_range(0,14)
        $RainDrops5.frame = drop_frame
        $RainDrops5.play("default")
        # completed
        rain_set = true