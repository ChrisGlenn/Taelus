extends Area2D
# HANGING SIGN
# A sign that will display a set text to the player
@export var SIGN_TITLE : String = "" # the title of the sign
@export_multiline var SIGN_DESC : String = "" # the sign description
@export_multiline var SIGN_TEXT : String = "" # the sign text
@export var FRAME_NO = 0


func _on_area_entered(area):
	pass # Replace with function body.
