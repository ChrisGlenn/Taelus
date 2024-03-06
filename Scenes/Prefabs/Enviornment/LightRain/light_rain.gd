extends CanvasLayer
# LIGHT RAIN
# light rain that fades in for a set amount of time and then fades out...
# this is done by using a bunch of animated sprites that are set to random start frames
# in an attempt to create rain that is far more resource friendly then a particle emitter
# SOUND GOES HERE
@onready var DROPLET = preload("res://Scenes/Prefabs/Enviornment/RainDroplet/rain_droplet.tscn")
@onready var RAINAUDIO = $RainAudio
@onready var LIGHTRAIN = $ParallaxBackground/ParallaxLayer/Sprite2D
@onready var PARALLAX = $ParallaxBackground
var lifespan = 1 # lifespan of rain defaults to 1 for testing
var hour_check : int # keeps track of hours for lifespan



func _ready():
	hour_check = Globals.hour # set to current hour upon creation
	#LIGHTRAIN.modulate.a = 0 # hide the rain

func _process(delta):
	rain(delta) # rain function


func rain(clock):
    # scroll the rain background
	PARALLAX.scroll_offset.x -= 180 * clock
	PARALLAX.scroll_offset.y += 180 * clock