extends StaticBody2D
# TREE SCRIPT
# a script for the variety of trees in Taelus (starting in the Lor region)
# see documentation for various tree types lifespan/ect.
@onready var ANIM_SPRITE = $AnimatedSprite2D
@export var record_tree = false # if set to true WILL RECORD TREE
@export var tree_id = "" # the ID of the tree
@export_enum("chestnut", "apple", "pine", "willow") var tree_species = "chestnut" # correlates to the 'animation'
@export var bear_fruit = false # if true this tree bears fruit
@export var tree_age = 19 # age in months
@export var will_seed = true # if the tree can seed new trees around it during Spring months
@export var seed_age = 2 # set to years
@export var cut_down = false # if the tree has been cut down
@export var tree_dead = false # if the tree is dead or not
@export var tree_life_milestones = [16,800] # goes from small to fully grown, goes into dead
@export var tree_seasonal_update = [3,1,1,4] # winter, spring, summer, fall the frames for each season (default chestnut)
var record_slot # the slot in the Globals array
var month_rec # records the current month
var month_check # used to check the passage of months
var year_check # used to check the passage of years


func _ready():
	# iterate through the global tree array and see if this tree is already listed. If so then load it
	# from there and if not then from the set variables
	if Globals.trees.size() > 0:
		for n in Globals.trees.size():
			if Globals.trees[n]["id"] == tree_id:
				break
	else:
		pass
	month_check = Globals.month # set to current month
	year_check = Globals.year # set to current year
	ANIM_SPRITE.play(tree_species) # set animation based off species


func _process(_delta):
	tree_aging() # tree growth/aging function


func tree_aging():
	# tree aging
	# check against the current season and change
	# check months/years and compare it to the set milestones
	if month_check != Globals.month:
		tree_age += 1 # increment age (recorded in months)
		month_rec = Globals.months_in_game # used to record months in game
	if !tree_dead:
		if tree_age < tree_life_milestones[0]:
			ANIM_SPRITE.frame = 0 # baby tree :D
		elif tree_age >= tree_life_milestones[0] and tree_age < tree_life_milestones[1]:
			ANIM_SPRITE.frame = 1 # tree
		elif tree_age >= tree_life_milestones[1]:
			tree_dead = true # the tree has died
	else:
		if tree_age < tree_life_milestones[0]:
			ANIM_SPRITE.frame = 2 # dead baby tree :(
		else:
			ANIM_SPRITE.frame = 3 # dead tree
	# seasonal check
	# will 

func record():
	# record the tree into the Globals if not recorded
	if record_tree:
		if !record_slot:
			# if there is no previous occurance of the tree in the record
			var tree_rec = {
				"id": tree_id,
				"age": tree_age,
				"cut_down": cut_down,
				"dead": tree_dead,
				"current_month": month_rec
			}
			Globals.trees.append(tree_rec) # add to the Globals array
			record_tree = false # recording done
		else:
			# there is a previous occurance of the tree in record will remove the record
			Globals.trees.remove_at(record_slot)
			var tree_rec = {
				"id": tree_id,
				"age": tree_age,
				"cut_down": cut_down,
				"dead": tree_dead,
				"current_month": month_rec
			}
			Globals.trees.append(tree_rec) # add to the Globals array
			record_tree = false # recording done

func fruit_production():
	pass