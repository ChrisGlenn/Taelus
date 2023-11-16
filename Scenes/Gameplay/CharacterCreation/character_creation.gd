extends Node2D
# CHARACTER CREATION
# This allows the player to create a character
# it's split into multpile sections that will establish a character
@onready var AVATAR = $AvatarCreation
var creation_section = "AVATAR" # character creation section that is active
var active_subsection = "RACE" # active section player is currently using
var can_choose = true # controller check


func _ready():
	AVATAR.visible = true # show avatar creation first

func _process(_delta):
	pass

