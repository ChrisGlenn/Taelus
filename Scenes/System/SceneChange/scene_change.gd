extends Area2D
# SCENE CHANGE
# when the player enters this collision shape the set next scene will load
@onready var FADEOUT = preload("res://Scenes/UI/FadeOut/fade_out.tscn")
@export var scene_to_load : String = ""
@export var coord_to_set : String = "Y"


func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		if scene_to_load.length() > 0:
			Globals.can_play = false # freeze player movement
			Globals.new_scene_player_origin = Vector2(128,body.global_position.y)
			Globals.new_scene_player_set = true # let the player know to move to the set coords
			# load the scene transition and feed in the level to load
			var fadeout = FADEOUT.instantiate()
			fadeout.level_to_load = scene_to_load
			get_parent().add_child(fadeout)
		else:
			# send error to Output
			print("ERROR: No scene_to_load set...")
