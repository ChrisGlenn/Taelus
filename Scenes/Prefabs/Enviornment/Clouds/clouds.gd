extends CanvasLayer
# CLOUDS
# scrolling clouds that display an overcast effect
# the clouds will fade in (once the sky is visible), and then fade out before it starts to get dark
# if it's lifespan is met
@onready var CLOUDS = $ParallaxBackground/ParallaxLayer/Sprite2D
@onready var PARALLAX = $ParallaxBackground
var lifespan = 1 # counted in hours
var hour_check = 0 # checks the current hour to set against lifespan
var dawn_dusk = [] # keeps track of dawn/dusk hours


func _ready():
    hour_check = Globals.hour # record the current hour
    CLOUDS.modulate.a = 0 # make sure the clouds aren't visible when spawned

func _process(delta):
    # scroll the background
    PARALLAX.scroll_offset.x -= 3 * delta
    PARALLAX.scroll_offset.y -= 3 * delta
    # check if interior and then hide
    if Globals.interior:
        CLOUDS.visible = false # hide if inside
    else:
        CLOUDS.visible = true # show if outside
    if Globals.hour > dawn_dusk[0] + 1:
        # slowly fade in and once the time is up then fade out/queue free self
        if lifespan > 0:
            # check the lifespan
            if hour_check != Globals.hour:
                lifespan -= 1 # decrement lifespan
                hour_check = Globals.hour # reset the hour_check
            # fade in
            if CLOUDS.modulate.a < 1.0:
                CLOUDS.modulate.a += 0.05 * delta # slowly fade in
            else:
                CLOUDS.modulate.a = 1.0 # set to 1
        else:
            if CLOUDS.modulate.a > 0:
                # decrement CLOUDS visibility until 0
                CLOUDS.modulate.a -= 0.05 * delta
            else:
                Globals.weather_updated = false # reset the weather
                queue_free() # delete self
    elif Globals.hour > dawn_dusk[1] - 1:
        # just end the clouds event
        if CLOUDS.modulate.a > 0:
            # decrement CLOUDS visibility until 0
            CLOUDS.modulate.a -= 0.05 * delta
        else:
            Globals.weather_updated = false # reset the weather
            queue_free() # delete self