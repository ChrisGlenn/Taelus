extends CanvasLayer
# SLEEP MENU
# if the player goes to sleep in a bed this menu pops up letting them select
# how many hours to sleep for or to cancel and not sleep
@onready var HOURS = $HourLabel
var sleep_hours = 1 # how many hours to sleep


func _ready():
    Globals.can_play = false # stop the player movement

func _process(_delta):
    HOURS.text = str(sleep_hours) # update the hour label with the selected sleep_hours
    sleep_controls() # sleep menu controls


func sleep_controls():
    # sleep controls
    # the player can increase/decrease the hours to sleep with the arrow keys (1 min and 12 max)
    # will start the sleep by pressing 'tae-select' or cancel with 'esc'
    if Input.is_action_just_pressed("tae_left"):
        if sleep_hours > 1:
            sleep_hours -= 1 # decrement hours to sleep
    elif Input.is_action_just_pressed("tae_right"):
        if sleep_hours < 12:
            sleep_hours += 1 # increment hours to sleep
    if Input.is_action_just_pressed("tae_cancel"):
        Globals.can_play = true # let the player play
        queue_free()