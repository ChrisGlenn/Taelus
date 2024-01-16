extends CanvasLayer
# NARRATIVE MESSSAGE
# this is a longer form of the message used for encounters/actions/ect that needs a 
# more descriptive message format
@onready var SPRITE = $Sprite2D
@onready var MESS_TEXT = $TextLabel


func _ready():
	pass

func _process(_delta):
	narrative_message() # message function

func narrative_message():
	if Input.is_action_just_pressed("tae_cancel"):
		# clear the globals and delete self
		Globals.narr_message_icon = 0 
		Globals.narr_message_text = ""
		queue_free() # delete self (close message)
