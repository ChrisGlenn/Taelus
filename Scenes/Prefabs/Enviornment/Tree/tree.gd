extends Area2D
# TREE SCRIPT
# a script for the variety of trees in Taelus (starting in the Lor region)
# see documentation for various tree types lifespan/ect.
# tree frame reference (0: chopped 1: baby 2: baby fall 3: baby snow 4: baby bare 5: adult 6: adult fruit 7: adult fall 8: adult snow 9: adult dead/bare)
# fill out the frames to 9 updating what is needed
@onready var ANIM_SPRITE = $AnimatedSprite2D
@onready var RAY = $RayCast2D
@export var TITLE = "Tree" # the wooden door title
@export var FRAME_NO = 35 # the image frame for the door
@export var DESCRIPTION = "A tree." # the description for the door
@export var HUD_CTRL_MODE = "sel_tree" # hud control mode
@export var hit_points = 10 # hit points for the tree
@export var tree_id = "" # the ID of the tree
@export_enum("chestnut", "apple", "pine", "willow") var tree_species = "chestnut" # correlates to the 'animation'
@export var bear_fruit = false # if true this tree bears fruit
@export var fruit_season = 5 # defaults to Sunsfir
@export var fruit_amount = 1 # how much fruit can be piced before there is no more
@export var tree_age = 19 # age in months
@export var seed_age = 100 # set to months (increments by 100 after seeding)
@export var cut_down = false # if the tree has been cut down
@export var tree_dead = false # if the tree is dead or not
@export var winter_snow = false # if true the tree will have snow during winter, otherwise is leafless
@export var fall_colour = false # if the leaves change color during fall
@export var tree_life_milestones = [16,800] # goes from small to fully grown, goes into dead
@export var tree_seasonal_update = [3,1,1,4] # winter, spring, summer, fall the frames for each season (default chestnut)
var fruit = false # if true then it's fruit time!
var record_slot # the slot in the Globals array
var month_rec # records the current month
var month_check # used to check the passage of months
var year_check # used to check the passage of years
var disabled = false # if true delete self
var selector_in = false # if true the selector is colliding


func _ready():
	# iterate through the global tree array and see if this tree is already listed. If so then load it
	# from there and if not then from the set variables
	if Globals.trees.size() > 0:
		for n in Globals.trees.size():
			if Globals.trees[n]["id"] == tree_id:
				record_slot = n # set the record slot
				print(Globals.trees[n]["id"])
				tree_age = Globals.trees[n]["age"] # set the tree_age
				cut_down = Globals.trees[n]["cut_down"] # set the cut_down
				tree_dead = Globals.trees[n]["dead"] # set the dead
				month_rec = Globals.trees[n]["current_month"] # set the month record
				disabled = Globals.trees[n]["disabled"] # set the disabled field
				break # break from loop
	month_check = Globals.month # set to current month
	month_rec = Globals.months_in_game # set the month record
	year_check = Globals.year # set to current year
	ANIM_SPRITE.play(tree_species)
	if disabled: 
		if record_slot: Globals.trees.remove_at(record_slot) # erase from the record if there is an entry
		queue_free() # delete self if disabled
	else:
		record() # record the tree

func _process(_delta):
	tree_life() # tree growth/aging function


func tree_life():
	# tree life
	# check against the current season and change
	# check months/years and compare it to the set milestones
	if month_check != Globals.month:
		tree_age += 1 # increment age (recorded in months)
		month_rec = Globals.months_in_game # used to record months in game
	# seasonal check
	# will check the seasons and then update the sprites accordingly
	# frame references (1 = green 4 = fall 5 = white/winter)
	if !tree_dead:
		if tree_age < tree_life_milestones[0]:
			# child tree
			if Globals.season == 0:
				# winter
				if winter_snow:
					ANIM_SPRITE.frame = 3 # snowy
				else:
					ANIM_SPRITE.frame = 4 # leafless
			elif Globals.season == 1:
				# spring
				ANIM_SPRITE.frame = 1
			elif Globals.season == 2:
				# summer
				ANIM_SPRITE.frame = 1
			elif Globals.season == 3:
				# fall
				if fall_colour:
					ANIM_SPRITE.frame = 2 # yellow
		else:
			# full grown tree
			if Globals.season == 0:
				# winter
				if winter_snow:
					ANIM_SPRITE.frame = 8 # snowy
				else:
					ANIM_SPRITE.frame = 9 # leafless
			elif Globals.season == 1:
				# spring
				ANIM_SPRITE.frame = 5
			elif Globals.season == 2:
				# summer
				if fruit:
					ANIM_SPRITE.frame = 6 # fruit
				else:
					ANIM_SPRITE.frame = 5 # no fruit
			elif Globals.season == 3:
				# fall
				if fruit:
					ANIM_SPRITE.frame = 6 # fruit
				else:
					# if no fruit
					if fall_colour:
						ANIM_SPRITE.frame = 7 # yellow
					else:
						ANIM_SPRITE.frame = 5 # normal
		if cut_down: tree_dead = true # kill the tree if it's cut down
	elif tree_dead:
		# change the lifespan so the stump will disappear after a certain amount of time
		if !cut_down:
			if tree_age < tree_life_milestones[0]:
				ANIM_SPRITE.frame = 4 # baby bare
			else:
				ANIM_SPRITE.frame = 9 # adult bare
		else:
			ANIM_SPRITE.frame = 0 # cut down
			disabled = true # disable so it won't load again
	# bearing fruit
	if bear_fruit:
		# if the tree is set to bear fruit wait until the set season and then switch to fruit frame
		if Globals.month == fruit_season:
			if fruit_amount > 0:
				fruit = true # set the fruit to true!
				if selector_in:
					pass
			else:
				fruit = false # set the tree back to standard fruitless
	# cutting the tree down
	if hit_points <= 0:
		# the tree's hit points are gone so set the tree to cutdown and then spawn
		# a pickup of some wood
		if !cut_down:
			cut_down = true # the check
	# recording/aging the tree
	if month_check != Globals.month:
		tree_age += 1 # increment by one month
		record() # record the tree


func record():
	# record the tree into the Globals if not recorded
	if !record_slot:
		# if there is no previous occurance of the tree in the record
		var tree_rec = {
			"id": tree_id,
			"age": tree_age,
			"cut_down": cut_down,
			"dead": tree_dead,
			"current_month": month_rec,
			"disabled": disabled
		}
		Globals.trees.append(tree_rec) # add to the Globals array
		get_record_slot() # get the record slot
		print(Globals.trees)
	else:
		# there is a previous occurance of the tree in record will remove the record
		Globals.trees.remove_at(record_slot)
		var tree_rec = {
			"id": tree_id,
			"age": tree_age,
			"cut_down": cut_down,
			"dead": tree_dead,
			"current_month": month_rec,
			"disabled": disabled
		}
		Globals.trees.append(tree_rec) # add to the Globals array

func get_record_slot():
	# get the current record slot
	if Globals.trees.size() > 0:
		for n in Globals.trees.size():
			if Globals.trees[n]["id"] == tree_id:
				record_slot = n # set the record slot
				print("Record Slot: ", record_slot) # DEBUG


func _on_area_entered(area:Area2D):
	if area.is_in_group("SELECTOR"):
		selector_in = true

func _on_area_exited(area:Area2D):
	if area.is_in_group("SELECTOR"):
		selector_in = false