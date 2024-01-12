extends CanvasLayer
# PAUSE MENU
# if the player hits the 'ESC' key then this menu pops up and pauses the game
# works in combat and out of combat.
var pause_mode = "PAUSED" # PAUSED, LOAD, SETTINGS, QUIT
var menu_modes = [true, false, false, false] # PAUSED, LOAD, SETTINGS, QUIT
var cur_pos = 0 # cursor position
var can_move = true # fixes input
var paused_positions = [16,32,48,64] # cursor positions for paused
var load_positions = [] # cursor positions for load
var settings_positions = [] # cursor positions for settings
var quit_positions = [44,60] # cursor positions for quit


func _ready():
	pass

func _process(_delta):
	control() # control function

func control():
	if pause_mode == "PAUSED":
		# main paused menu
		menu_modes = [true, false, false, false]
		if Input.is_action_just_pressed("tae_down"):
			if cur_pos < paused_positions.size()-1:
				cur_pos += 1 # inc cur_pos
				can_move = false 
		elif Input.is_action_just_pressed("tae_up"):
			if cur_pos > 0: 
				cur_pos -= 1 # dec cur_pos
				can_move = false
		elif Input.is_action_just_pressed("tae_enter"):
			if can_move:
				match cur_pos:
					0:
						# resume
						# unpause
						queue_free() # delete pause menu
					1:
						# load game
						print("Not implemented yet...")
						pause_mode = "LOAD" # move to load mode
						can_move = false
					2:
						# settings
						print("Not implemented yet...")
						pause_mode = "SETTINGS" # move to settings mode
						can_move = false
					3:
						# quit game
						cur_pos = 0 # reset cur_pos
						pause_mode = "QUIT" # move to quit mode
						can_move = false
		else:
			can_move = true
		# update cursor position
		$Paused/PCursor.position = Vector2(12,paused_positions[cur_pos])
	if pause_mode == "QUIT":
		# the quit menu
		menu_modes = [false, false, false, true]
		if Input.is_action_just_pressed("tae_down"):
			if cur_pos < quit_positions.size()-1:
				cur_pos += 1 # inc cur_pos
				can_move = false
		elif Input.is_action_just_pressed("tae_up"):
			if cur_pos > 0: 
				cur_pos -= 1 # dec cur_pos
				can_move = false
		elif Input.is_action_just_pressed("tae_enter"):
			if can_move:
				match cur_pos:
					0:
						# no
						cur_pos = 0 # reset cur_pos
						pause_mode = "PAUSED" # return
						can_move = false
					1:
						# yes
						get_tree().quit() # quit game
		else:
			can_move = true
		# update cursor position
		$Quit/QCursor.position = Vector2(32,quit_positions[cur_pos])
	# menu visibility update
	$Paused.visible = menu_modes[0]
	$Quit.visible = menu_modes[3]
