extends CharacterBody2D
# PLAYER SCRIPT
# handles movement, interaction, ect. all the things a player script should
@onready var RAY = $RayCast2D # raycast reference
@onready var BODY = $Body # body sprite reference

var is_moving: bool = false # if the player is moving
var move_direction: String # UP, DOWN, LEFT, RIGHT
var move_target: int # target to move towards


func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	player_movement(delta) # movement function


func player_movement(clock):
	# input/movement idea list:
	# check input and raycast to position
	# if no collision then set the player to move in that direction
	# check if the player is near the position and if the button is still pressed...
	# if so then decrement the movement, set it to the direction the player wants to continue
	# in... see if that works for grid movement
	# also throw in the animation
	if !is_moving:
		if Input.is_action_pressed("tae_down"):
			if RAY.target_position.y != 16:
				RAY.target_position = Vector2(0,16) # set 'down' target position
			else:
				if !RAY.is_colliding():
					print("DOWN")
					move_direction = "DOWN"
					move_target = global_position.y + 16
					is_moving = true
	else:
		if move_direction == "DOWN":
			if global_position.y < move_target:
				position.y += Globals.movement_speed * clock
				# check if button is still pressed and then increase the target
				# by 16 PLUS the move_target
				if global_position.y >= move_target-1:
					if Input.is_action_pressed("tae_down"):
						move_target = move_target + 16
			else:
				global_position.y = move_target
				is_moving = false
