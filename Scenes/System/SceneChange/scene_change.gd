extends Area2D
# SCENE CHANGE
# when the player enters this collision shape the set next scene will load
@export var scene_to_load : String = ""


func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		if scene_to_load.length() > 0:
			Globals.can_play = false # freeze player movement
			# load the scene transition and feed in the level to load
		else:
			# send error to Outpu
			print("ERROR: No scene_to_load set...")
