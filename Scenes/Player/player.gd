extends CharacterBody2D
# PLAYER SCRIPT
# handles movement, interaction, ect. all the things a player script should
@onready var RAY = $RayCast2D # raycast reference
@onready var BODY = $Body # body sprite reference

var is_moving: bool = false # if the player is moving
var move_target: Vector2 # target to move towards


func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	player_movement(delta) # movement function


func player_movement(_clock):
	# input/movement idea list:
	# check input and raycast to position
	# if no collision then set the player to move in that direction
	# check if the player is near the position and if the button is still pressed...
	# if so then decrement the movement, set it to the direction the player wants to continue
	# in... see if that works for grid movement
	# also throw in the animation
	if !is_moving:
		if Input.is_action_pressed("tae_down"):
			pass
