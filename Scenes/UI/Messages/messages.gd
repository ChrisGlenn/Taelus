extends CanvasLayer
# MESSAGE SCRIPT
# the message is given a location based off the number in the array it is and once
# created will move UP to the location set where it will sit for a bit then delete itself...
var message_text = "" # the text of the message
var message_no = 0 # used to possibly reset
var has_set = false # if it has originally set
var life_timer = 260 # lifspan timer
var timer_ctrl = 100 # timer control


func _ready():
	$MsgBackground/MsgLabel.text = message_text # update the text
	$MsgBackground.position.y = 24 * Globals.messages

func _process(delta):
	message(delta) # message function

func message(clock):
	# check the lifetime timer and decrement
	if life_timer > 0:
		life_timer -= timer_ctrl * clock # decrement timer
	else:
		# check to see if the messages amount needs to be reset
		if message_no == Globals.messages:
			Globals.messages = -1 # reset
			call_deferred('free')
		else:
			queue_free() # delete self
