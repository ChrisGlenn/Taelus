extends CanvasLayer
# WEATHER PARTICLES
# this scene controls particle based weather systems (rain, snow, wind)
# it will slowly increment the particle amount over time until the max is reached
# then wait until it's done and decrement until 0 and then deletes itself
@onready var RAINPART = $Rain
var lifespan = 1 # counted in hours
var hour_rec = 0 # used to keep track of passed hours in game


func _ready():
	hour_rec = Globals.hour # record initial hour

func _process(_delta):
	pass