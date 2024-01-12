extends CanvasLayer
# MESSAGE SCRIPT
# the message is given a location based off the number in the array it is and once
# created will move UP to the location set where it will sit for a bit then delete itself...
var move_speed = 80 # movement speed
var message_text = "" # the text of the message
var y_to = 0 # Y coord to move up to
var has_set = false # if it has originally set
var life_timer = 300 # lifspan timer
var timer_ctrl = 100 # timer control


func _ready():
	$MsgBackground/MsgLabel.text = message_text # update the text

func _process(delta):
	movement(delta) # movement function

func movement(clock):
	# if the message Y is greater than the set y_to the move up...
	if offset.y > y_to:
		offset.y -= move_speed * clock
	else:
		offset.y = y_to
	# check the lifetime timer and decrement
	if life_timer > 0:
		life_timer -= timer_ctrl * clock # decrement timer
	else:
		queue_free() # delete self
