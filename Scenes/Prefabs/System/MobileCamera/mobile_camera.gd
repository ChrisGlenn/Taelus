extends Camera2D
# MOBILE CAMERA
# this camera moves when the player hits a 'scene transition' block
# it will give the camera a direction and set x/y to move to
@export var player : CharacterBody2D # the player


func _process(_delta):
    if player.global_position.x > global_position.x + 640:
        global_position.x = global_position.x + 512
    elif player.global_position.x < global_position.x + 126:
        if global_position.x > 0:
            global_position.x = global_position.x - 512