extends Area2D
# HORSE
# The horse will move around randomly at certain intervals. If spooked will try to flee offscreen 
# NEVER TO BE SEEN AGAIN.
@onready var RAY = $RayCast2D
@onready var HSPRITE = $Sprite2D
@onready var RNG = RandomNumberGenerator.new() # random number generator
var can_move = true # if false the timer stops along with any movement
var move = false # if it's time to move or not
var moving = false # check if moving
var move_dir = 0 # 0 to 3 clockwise (0 up 1 right 2 down 3 left)
var move_speed = 78 # movement speed
var move_to = 0 # position to move to
var spooked = false # if the horse is spooked or not
var distance_check = 32 # distance from player to stop movement


func _ready():
	RNG.randomize() # seed random

func _physics_process(delta):
	move_horse(delta) # movement function
	# check distance to player to pause movement to stop any collision
	if global_position.distance_to(Vector2(Globals.player_x, Globals.player_y)) < 32:
		can_move = false
	else:
		can_move = true

func move_horse(clock):
	if can_move:
		$Timer.paused = false # unpause timer
		if move:
			if !moving:
				# if moving is true (set by the timer) then get the direction and coord randomly
				# set by the timeout signal and move to that.
				if move_dir == 0:
					# UP
					if RAY.target_position.y != -16:
						RAY.target_position = Vector2(0,-16)
					else:
						if !RAY.is_colliding():
							move_to = global_position.y - 16
							moving = true
				elif move_dir == 1:
					# RIGHT
					if RAY.target_position.x != 16:
						RAY.target_position = Vector2(16,0)
					else:
						if !RAY.is_colliding():
							move_to = global_position.x + 16
							moving = true
				elif move_dir == 2:
					# DOWN
					if RAY.target_position.y != 16:
						RAY.target_position = Vector2(0,16)
					else:
						if !RAY.is_colliding():
							move_to = global_position.y + 16
							moving = true
				elif move_dir == 3:
					# LEFT
					if RAY.target_position.x != -16:
						RAY.target_position = Vector2(-16,0)
					else:
						if !RAY.is_colliding():
							move_to = global_position.x - 16
							moving = true
			else:
				# move towards the set direction/position
				if move_dir == 0:
					# MOVE UP
					if global_position.y > move_to:
						# move the horsey
						position.y -= Globals.movement_speed * clock
					else:
						global_position.y = move_to # make sure it hasn't gone past
						moving = false # complete move
						move = false # complete move
				elif move_dir == 1:
					# MOVE RIGHT
					if global_position.x < move_to:
						# move the horsey
						HSPRITE.flip_h = true # flip the sprite
						position.x += Globals.movement_speed * clock
					else:
						global_position.x = move_to # make sure it hasn't gone past
						moving = false # complete move
						move = false # complete move
				elif move_dir == 2:
					# MOVE DOWN
					if global_position.y < move_to:
						# move the horsey
						position.y += Globals.movement_speed * clock
					else:
						global_position.y = move_to # make sure it hasn't gone past
						moving = false # complete move
						move = false # complete move
				elif move_dir == 3:
					# MOVE LEFT
					if global_position.x > move_to:
						# move the player
						HSPRITE.flip_h = false # reset the sprite 'flip'
						position.x -= Globals.movement_speed * clock
					else:
						global_position.x = move_to # make sure it hasn't gone past
						moving = false # complete move
						move = false # complete move
	else:
		# if the horse can't move then pause the timer
		$Timer.paused = true

func _on_timer_timeout():
	move_dir = RNG.randi_range(0,3) # set random move dir
	move = true # let the horse know it's time to move
