extends Camera2D
# MOBILE CAMERA
# this camera moves when the player hits a 'scene transition' block
# it will give the camera a direction and set x/y to move to
@export var player : CharacterBody2D # the player


func _process(_delta):
	follow_player() # follow player function


func follow_player():
	if player:
		# horizontal
		if player.global_position.x > global_position.x + 640:
			if Globals.location_marker_dir == 3:
				Globals.location_marker_dir = 1 # right
			else:
				Globals.cam_move_count += 1 # increment camera movement count
				Globals.location_marker_dir = 1 # right
			Globals.active_scene.swap_active("RIGHT")
			global_position.x = global_position.x + 512
		elif player.global_position.x < global_position.x + 126:
			if global_position.x > 0:
				if Globals.location_marker_dir == 1:
					Globals.location_marker_dir = 3 # left
				else:
					Globals.cam_move_count += 1 # increment camera movement count
					Globals.location_marker_dir = 3 # left
				Globals.active_scene.swap_active("LEFT")
				global_position.x = global_position.x - 512
		# vertical
		if player.global_position.y < global_position.y:
			if Globals.location_marker_dir == 2:
				Globals.location_marker_dir = 0 # up
			else:
				Globals.cam_move_count += 1 # increment camera movement count
				Globals.location_marker_dir = 0 # up
			Globals.location_marker_dir = 0 # up
			Globals.active_scene.swap_active("UP")
			global_position.y = global_position.y - 360
		elif player.global_position.y > global_position.y + 360:
			if Globals.location_marker_dir == 0:
				Globals.location_marker_dir = 2 # down
			else:
				Globals.cam_move_count += 1 # increment camera movement count
				Globals.location_marker_dir = 2 # down
			Globals.active_scene.swap_active("DOWN")
			global_position.y = global_position.y + 360
	else:
		print("ERROR: PLAYER NOT SET...")
