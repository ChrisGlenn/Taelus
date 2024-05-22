extends StaticBody2D
# TREE SCRIPT
# a script for the variety of trees in Taelus (starting in the Lor region)
# see documentation for various tree types lifespan/ect.
@onready var ANIM_SPRITE = $AnimatedSprite2D
@export var tree_id = "" # the ID of the tree
@export_enum("chestnut", "apple") var tree_species = "chestnut" # correlates to the 'animation'
@export var tree_age = 0 # age in months
@export var will_seed = true # if the tree can seed new trees around it during Spring months
@export var seed_age = 2 # set to years
@export var cut_down = false # if the tree has been cut down
@export var dead = false # if the tree is dead or not
var tree_life_milestones = [16,800] # goes from small to fully grown, goes into dead
var tree_seasonal_update = [3,1,1,4] # winter, spring, summer, fall the frames for each season (default chestnut)
var month_check # used to check the passage of months
var year_check # used to check the passage of years


func _ready():
	# iterate through the global tree array and see if this tree is already listed. If so then load it
	# from there and if not then from the set variables
	if Globals.trees.size() > 0:
		pass
	else:
		pass
	month_check = Globals.month # set to current month
	year_check = Globals.year # set to current year
	ANIM_SPRITE.play(tree_species) # set animation based off species


func _process(_delta):
	tree_aging() # tree growth/aging function


func tree_aging():
	# check against the current season and change
	# check months/years and compare it to the set milestones
	if month_check != Globals.month:
		tree_age += 1 # increment age (recorded in months)
	if tree_age < tree_life_milestones[0]:
		if !dead: ANIM_SPRITE.frame = 0 # baby tree :D
		else: ANIM_SPRITE.frame = 2 # dead baby tree :(
	elif tree_age >= tree_life_milestones[0] and tree_age < tree_life_milestones[1]:
		ANIM_SPRITE.frame = 1 # tree
	elif tree_age >= tree_life_milestones[1]:
		ANIM_SPRITE.frame = 3 # dead adult

func record_tree():
	# record the tree into the Globals if not recorded
	pass