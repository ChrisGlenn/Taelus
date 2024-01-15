extends Area2D
# INVISIBLE BLOCK
# used to block off the player
# if this is set 'border' to true then it will display a message telling the player that
# they can go no further
@export var border = false


func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		Functions.message("You can go no further...")
