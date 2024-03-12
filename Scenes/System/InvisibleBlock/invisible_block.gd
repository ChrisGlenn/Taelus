extends Area2D
# INVISIBLE BLOCK
# used to block off the player
# if this is set 'border' to true then it will display a message telling the player that they can go no further
# if set to 'interior' then it will set the player's interior status to true but false if exited...
@export var border = false
@export var interior = false


func _ready():
	if interior:
		# for interior = true
		# turn off collision
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		# turn on collision for interior
		set_collision_layer_value(9, true)
		set_collision_mask_value(9, true)


func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		if border:
			Functions.message("You can go no further...")
		if interior:
			Globals.interior = true # set interior to true

func _on_body_exited(body:Node2D):
	if body.is_in_group("PLAYER"):
		if interior:
			Globals.interior = false # set interior to false
