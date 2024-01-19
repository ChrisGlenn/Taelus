extends AudioStreamPlayer2D
# AUDIO SOURCE
# a blank 2d audio source for your general needs
@export var auto_start = true # if this automatically starts or not


func _ready():
	if stream: 
		if auto_start: play()
	else:
		print(str("ERROR: No audio set in stream for ", self))
