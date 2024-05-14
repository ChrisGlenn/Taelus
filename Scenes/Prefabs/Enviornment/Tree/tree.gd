extends StaticBody2D
# TREE SCRIPT
# a script for the variety of trees in Taelus (starting in the Lor region)
# see documentation for various tree types lifespan/ect.
var tree_id = "" # the ID of the tree
var tree_recorded = false # if true then this tree has a listing in the Globals.tree array
var tree_species = "chestnut" # correlates to the 'animation'
var tree_age = 0 # age in months
var tree_life_milestones = [16,800] # goes from small to fully grown, goes into dead
var tree_seasonal_update = [3,1,1,4] # winter, spring, summer, fall the frames for each season (default chestnut)
var will_seed = true # if the tree can seed new trees around it during Spring months
var seed_age = 2 # set to years
var cut_down = false # if the tree has been cut down
var month_check # used to check the passage of months
var year_check # used to check the passage of years


func _ready():
	# iterate through the global tree array and see if this tree is already listed. If so then load it
	# from there and if not then from the set variables
	if Globals.trees.size() > 0:
		pass
	if !tree_recorded:
		# load the tree based on the variables set by the scene this spawned into
		pass
	month_check = Globals.month # set to current month
	year_check = Globals.year # set to current year

func _process(_delta):
	pass