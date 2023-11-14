extends Area2D
# SCENE CHANGE
# when the player enters this collision shape the set next scene will load
@export var direction : String = "1" # 0 = up 1 = right 2 = down 3 = left
@export var camera : Camera2D # the camera to control


func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		if camera:
			Globals.can_play = false # stop player movement
			# move the camera in the direction set
			if direction == "0":
				# up
				pass
			elif direction == "1":
				# right
				var new_camera_position = camera.global_position.x + 320
				# move camera function
			elif direction == "2":
				# down
				pass
			elif direction == "3":
				# left
				pass
		else:
			print("ERROR: No camera is assigned...")
