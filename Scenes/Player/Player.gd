extends CharacterBody2D
# PLAYER SCRIPT
# controls the player
@onready var RAY = $RayCast2D
@onready var SELECTOR = $Selector
var select_mode = false # if the player is trying to select something w/ the cursor
var select_pos = 1 # 0 to 3 clockwise from up to left
var move_dir = 0 # 0 to 3 clockwise from up to left
var move_to = 0 # position to move to based on the move_dir
var moving = false # if the player is moving currently
var combat_steps = 0 # how many steps the player can take in combat
var minute_check = 0 # checks minutes
var day_check = 0 # checks days
# outside scenes
var selected = null 


func _ready():
	SELECTOR.visible = false # hide the selector on creation
	if Globals.new_scene_player_set: 
		print("New scene set coords")
		global_position = Globals.new_scene_player_origin
	Globals.player_x = global_position.x # update player X
	Globals.player_y = global_position.y # update player Y
	day_check = Globals.day # set the day check
	minute_check = Globals.minutes # set the minute check

func _process(_delta):
	time_check() # time check function

func _physics_process(delta):
	if !Globals.in_combat and Globals.can_play: 
		player_movement(delta) # movement function
		selection() # selection function

func player_movement(clock):
	Globals.player_x = global_position.x # update player X
	Globals.player_y = global_position.y # update player Y
	# player movement function
	if !moving and !select_mode:
		# check input
		if Input.is_action_pressed("tae_right"):
			# MOVE RIGHT
			# cast the ray and check for collision and if none then move
			if RAY.target_position.x != 16:
				#ANIM.flip_h = false # face right
				$Body.flip_h = false
				$Hair.flip_h = false
				$Clothing.flip_h = false
				RAY.target_position = Vector2(16,0)
				select_pos = 1 # set select pos
			else: 
				if !RAY.is_colliding():
					move_dir = 1 # right
					move_to = global_position.x + 16
					moving = true
		if Input.is_action_pressed("tae_left"):
			# MOVE LEFT
			# cast the ray and check for collision
			if RAY.target_position.x != -16:
				#ANIM.flip_h = true # face left
				$Body.flip_h = true
				$Hair.flip_h = true
				$Clothing.flip_h = true
				RAY.target_position = Vector2(-16,0)
				select_pos = 3 # set select pos
			else:
				if !RAY.is_colliding():
					move_dir = 3 # left
					move_to = global_position.x - 16
					moving = true
		if Input.is_action_pressed("tae_up"):
			# MOVE UP
			# cast the ray and check for collision
			if RAY.target_position.y != -16:
				RAY.target_position = Vector2(0,-16)
				select_pos = 0 # set select pos
			else:
				if !RAY.is_colliding():
					move_dir = 0 # up
					move_to = global_position.y - 16
					moving = true
		if Input.is_action_pressed("tae_down"):
			# MOVE DOWN
			# cast the ray and check for collision
			if RAY.target_position.y != 16:
				RAY.target_position = Vector2(0,16)
				select_pos = 2 # set select pos
			else:
				if !RAY.is_colliding():
					move_dir = 2 # down
					move_to = global_position.y + 16
					moving = true
		# selection input
		if Input.is_action_just_pressed("tae_mode"):
			Globals.hud_controlable = false # stop hud swapping
			select_mode = true # turn on select mode to enable cursor
		# pause the game
		if Input.is_action_just_pressed("tae_cancel"):
			Functions.pause()
	elif moving and !select_mode:
		# move the player and animate the sprite
		if move_dir == 0:
			# MOVE UP
			if global_position.y > move_to:
				# move the player
				position.y -= Globals.movement_speed * clock
			else:
				global_position.y = move_to # make sure it hasn't gone past
				moving = false # complete move
		elif move_dir == 1:
			# MOVE RIGHT
			if global_position.x < move_to:
				# move the player
				position.x += Globals.movement_speed * clock
			else:
				global_position.x = move_to # make sure it hasn't gone past
				moving = false # complete move
		elif move_dir == 2:
			# MOVE DOWN
			if global_position.y < move_to:
				# move the player
				position.y += Globals.movement_speed * clock
			else:
				global_position.y = move_to # make sure it hasn't gone past
				moving = false # complete move
		elif move_dir == 3:
			# MOVE LEFT
			if global_position.x > move_to:
				# move the player
				position.x -= Globals.movement_speed * clock
			else:
				global_position.x = move_to # make sure it hasn't gone past
				moving = false # complete move
	# DEBUG
	if Input.is_action_just_pressed("tae_end"):
		get_tree().quit()

func time_check():
	# this keeps track of time for player specific time instances like hunger/thirst/ect 
	# as long as the player is not in combat
	if !Globals.combat:
		if day_check != Globals.day:
			if Globals.player["days_left"] > 0: Globals.player["days_left"] -= 1 # decrement lifespan by a day
			else: death() # or kill the player if their days have ended
			day_check = Globals.day # reset day check
		if minute_check != Globals.minutes:
			if Globals.player["hunger"] > 0: Globals.player["hunger"] -= 0.5 # decrement hunger
			else: death()
			if Globals.player["thirst"] > 0: Globals.player["thirst"] -= 1 # decrement thirst
			else: death()
			minute_check = Globals.minutes # reset minute check

func selection():
	if select_mode:
		SELECTOR.visible = true # show selector
		# set the cursor positiion
		if select_pos == 0:
			# UP
			SELECTOR.position = Vector2(0,-16)
		elif select_pos == 1:
			# RIGHT
			SELECTOR.position = Vector2(16,0)
		elif select_pos == 2:
			# DOWN
			SELECTOR.position = Vector2(0,16)
		elif select_pos == 3:
			# LEFT
			SELECTOR.position = Vector2(-16,0)
		# controls
		# get player input and move the selector
		if Input.is_action_just_pressed("tae_up"):
			select_pos = 0
		elif Input.is_action_just_pressed("tae_right"):
			#ANIM.flip_h = false # turn towards selector
			$Body.flip_h = false
			$Hair.flip_h = false
			$Clothing.flip_h = false
			$Weapon.flip_h = false
			select_pos = 1
		elif Input.is_action_just_pressed("tae_down"):
			select_pos = 2
		elif Input.is_action_just_pressed("tae_left"):
			#ANIM.flip_h = true # turn towards selector
			$Body.flip_h = true
			$Hair.flip_h = true
			$Clothing.flip_h = true
			$Weapon.flip_h = true
			select_pos = 3
		elif Input.is_action_just_pressed("tae_cancel"):
			Globals.hud_controlable = true # can swap huds
			select_mode = false # turn off select mode
	else:
		# hide the selector if outside of select_mode
		SELECTOR.visible = false
		SELECTOR.position = Vector2(0,0)

func death():
	# the player has died
	# check for permadeth and erase saves if so
	# but for now just print that the player has died and end the game
	print("Thou art DEAD")
	get_tree().quit()

func update_selector():
	if select_mode:
		if selected:
			Globals.hud_selected_name = selected.TITLE
			Globals.hud_selected_desc = selected.DESCRIPTION
			Globals.hud_sel_icon_frame = selected.FRAME_NO
			Globals.hud_control_mode = selected.HUD_CTRL_MODE

func _on_selector_area_entered(area):
	if select_mode:
		selected = area
		Globals.hud_mode = "SELECT"
		Globals.hud_selected_name = selected.TITLE
		Globals.hud_selected_desc = selected.DESCRIPTION
		Globals.hud_sel_icon_frame = selected.FRAME_NO
		Globals.hud_control_mode = selected.HUD_CTRL_MODE

func _on_selector_area_exited(_area):
	selected = null # reset
	Globals.hud_mode = "MAIN"
