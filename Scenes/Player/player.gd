extends CharacterBody2D
# PLAYER SCRIPT
# handles movement, interaction, ect. all the things a player script should

var is_moving: bool = false # if the player is moving
var move_direction: String # UP, DOWN, LEFT, RIGHT
var move_target: int # target to move towards


func _ready():
	pass

func _process(_delta):
	pass

func _physics_process(delta):
	player_movement(delta) # movement function


func player_movement(_clock):
	pass
