extends CharacterBody2D
# PLAYER SCRIPT
# controls the player
@onready var RAY = $RayCast2D
@onready var SELECTOR = $Selector
@export var player_speed : int = 80 # player movement speed
var select_mode = false # if the player is trying to select something w/ the cursor
var select_pos = 1 # 0 to 3 clockwise from up to left
var move_dir = 0 # 0 to 3 clockwise from up to left
var move_to = 0 # position to move to based on the move_dir
var moving = false # if the player is moving currently
var combat_steps = 0 # how many steps the player can take in combat


# SYSTEM FUNCTIONS
func _ready():
	SELECTOR.visible = false # hide the selector on creation
	if Globals.new_scene_player_set: 
		print("New scene set coords")
		global_position = Globals.new_scene_player_origin

func _process(_delta):
	selection() # selection function

func _physics_process(delta):
	if !Globals.in_combat and Globals.can_play: player_movement(delta) # movement function


# CUSTOM FUNCTIONS
func player_movement(clock):
	# player movement function
	if !moving and !select_mode:
		# check input
		if Input.is_action_pressed("tae_right"):
			# MOVE RIGHT
			# cast the ray and check for collision and if none then move
			if RAY.target_position.x != 8:
				#ANIM.flip_h = false # face right
				RAY.target_position = Vector2(8,0)
				select_pos = 1 # set select pos
			else: 
				if !RAY.is_colliding():
					move_dir = 1 # right
					move_to = global_position.x + 16
					moving = true
		if Input.is_action_pressed("tae_left"):
			# MOVE LEFT
			# cast the ray and check for collision
			if RAY.target_position.x != -8:
				#ANIM.flip_h = true # face left
				RAY.target_position = Vector2(-8,0)
				select_pos = 3 # set select pos
			else:
				if !RAY.is_colliding():
					move_dir = 3 # left
					move_to = global_position.x - 16
					moving = true
		if Input.is_action_pressed("tae_up"):
			# MOVE UP
			# cast the ray and check for collision
			if RAY.target_position.y != -8:
				RAY.target_position = Vector2(0,-8)
				select_pos = 0 # set select pos
			else:
				if !RAY.is_colliding():
					move_dir = 0 # up
					move_to = global_position.y - 16
					moving = true
		if Input.is_action_pressed("tae_down"):
			# MOVE DOWN
			# cast the ray and check for collision
			if RAY.target_position.y != 8:
				RAY.target_position = Vector2(0,8)
				select_pos = 2 # set select pos
			else:
				if !RAY.is_colliding():
					move_dir = 2 # down
					move_to = global_position.y + 16
					moving = true
		# selection input
		if Input.is_action_just_pressed("tae_mode"):
			select_mode = true # turn on select mode to enable cursor
	elif moving and !select_mode:
		# move the player and animate the sprite
		if move_dir == 0:
			# MOVE UP
			if global_position.y > move_to:
				# move the player
				position.y -= player_speed * clock
			else:
				global_position.y = move_to # make sure it hasn't gone past
				moving = false # complete move
		elif move_dir == 1:
			# MOVE RIGHT
			if global_position.x < move_to:
				# move the player
				position.x += player_speed * clock
			else:
				global_position.x = move_to # make sure it hasn't gone past
				moving = false # complete move
		elif move_dir == 2:
			# MOVE DOWN
			if global_position.y < move_to:
				# move the player
				position.y += player_speed * clock
			else:
				global_position.y = move_to # make sure it hasn't gone past
				moving = false # complete move
		elif move_dir == 3:
			# MOVE LEFT
			if global_position.x > move_to:
				# move the player
				position.x -= player_speed * clock
			else:
				global_position.x = move_to # make sure it hasn't gone past
				moving = false # complete move
	# DEBUG
	if Input.is_action_just_pressed("tae_end"):
		get_tree().quit()

func selection():
	if select_mode:
		SELECTOR.visible = true # show selector
		# set the cursor positiion
		if select_pos == 0:
			# UP
			SELECTOR.position = Vector2(0,-8)
		elif select_pos == 1:
			# RIGHT
			SELECTOR.position = Vector2(8,0)
		elif select_pos == 2:
			# DOWN
			SELECTOR.position = Vector2(0,8)
		elif select_pos == 3:
			# LEFT
			SELECTOR.position = Vector2(-8,0)
		# controls
		# get player input and move the selector
		if Input.is_action_just_pressed("tae_up"):
			select_pos = 0
		elif Input.is_action_just_pressed("tae_right"):
			#ANIM.flip_h = false # turn towards selector
			select_pos = 1
		elif Input.is_action_just_pressed("tae_down"):
			select_pos = 2
		elif Input.is_action_just_pressed("tae_left"):
			#ANIM.flip_h = true # turn towards selector
			select_pos = 3
		elif Input.is_action_just_pressed("tae_cancel"):
			select_mode = false # turn off select mode
		elif Input.is_action_just_pressed("tae_select"):
			pass
	else:
		# hide the selector if outside of select_mode
		SELECTOR.visible = false


# SIGNAL FUNCTIONS
