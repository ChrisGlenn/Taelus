extends Node2D
# CARROT
# carrot that will grow and become ready for harvest...or sit in the ground and rot.
var can_grow = true # false if not during the spring/summer
var stage = "SEED" # SEED, RIPE, ROTTEN are the 3 stages
var days_to_grow = 0 # 34 days till ripe
var days_to_rotten = 0 # 56 days till rotten


func _ready():
	# check the season to see if it can grow
	if Globals.season == "winter" or Globals.season == "fall":
		can_grow = false

func _process(_delta):
	if can_grow:
		# frame advancement and status update
		if days_to_grow < 11: 
			# seed
			stage = "SEED"
			$Sprite2D.frame = 1
		elif days_to_grow >= 11 and days_to_grow < 22:
			# seedling
			$Sprite2D.frame = 2
		elif days_to_grow >= 22 and days_to_grow < 34:
			# plant
			$Sprite2D.frame = 3
		elif days_to_grow >= 34 and days_to_grow < 56:
			# ripe
			stage = "RIPE"
			$Sprite2D.frame = 4
		else:
			# rotten
			stage = "ROTTEN"
			$Sprite2D.frame = 5
	else:
		# won't grow will stay seed until rotten days
		if days_to_grow < 10:
			stage = "SEED"
			$Sprite2D.frame = 1
		else:
			# delete self instead of going rotten
			queue_free()
