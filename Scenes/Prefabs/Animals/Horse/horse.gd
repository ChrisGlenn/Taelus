extends Area2D
# HORSE
# The horse will move around randomly at certain intervals. If spooked will try to flee offscreen 
# NEVER TO BE SEEN AGAIN.
@onready var RAY = $RayCast2D
@onready var SPRITE = $Sprite2D
var moving = false # check if moving
var move_dir = 0 # 0 to 3 clockwise (0 up 1 right 2 down 3 left)
var move_speed = 78 # movement speed
var spooked = false # if the horse is spooked or not


func _ready():
	pass

func _physics_process(_delta):
	pass

func move_horse(_clock):
	pass

func _on_timer_timeout():
	print("DONE")
