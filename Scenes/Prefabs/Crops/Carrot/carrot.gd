extends Node2D
# CARROT
# carrot that will grow and become ready for harvest...or sit in the ground and rot.
var identifier = 1 # crop identifier
var crop_name = "Carrot" # this is for the selector/HUD
var crop_desc = "An orange root vegetable. Grows in the Spring and Summer." # this is for the selector/HUD
var crop_img = 6 # this is for the selector/HUD
var can_grow = true # false if not during the spring/summer
var stage = "SEED" # SEED, RIPE, ROTTEN are the 3 stages
var days_to_grow = 0 # 34 days till ripe 56 days till rotten
var current_day = Globals.day # keeps track of day


func _ready():
	# check the season to see if it can grow
	if Globals.season == 0 or Globals.season == 3:
		can_grow = false
	# create an entry in the globals
	Globals.chunk_days["this_id"] = {"id": identifier, "pos": global_position.x}
	print(Globals.chunk_days)

func _process(_delta):
	carrot() # carrot function
	day_counter() # day counter function

func carrot():
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
			# change crop desc for selector
			crop_name = "Rotten Carrot"
			crop_desc = "An orange root vegetable that has been in the ground too long."
			crop_img = 7
			$Sprite2D.frame = 5
	else:
		# won't grow will stay seed until rotten days
		if days_to_grow < 10:
			stage = "SEED"
			$Sprite2D.frame = 1
		else:
			# delete self instead of going rotten
			queue_free()

func day_counter():
	# check if there is a new day and then increment days_to_grow
	if current_day != Globals.day:
		days_to_grow += 1 # increment days to grow
		current_day = Globals.day # update the current day
